/* ----------------------------------------------------------------
RESEARCH ONLY LICENSE
Copyright © 2015-2016 North Carolina State University.
All rights reserved.
Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:

1. Redistributions and use are permitted for internal research purposes only, 
and commercial use is strictly prohibited under this license. Inquiries 
regarding commercial use should be directed to the Office of Technology 
Transfer at North Carolina State University, 919‐215‐7199, https://research.
ncsu.edu/ott/contact‐us/, techtransfer@ncsu.edu.

2. Commercial use means the sale, lease, export, transfer, conveyance or other 
distribution to a third party for financial gain, income generation or other 
commercial purposes of any kind, whether direct or indirect. Commercial use 
also means providing a service to a third party for financial gain, income 
generation or other commercial purposes of any kind, whether direct or 
indirect.

3. Redistributions of source code must retain the above copyright notice, this 
list of conditions and the following disclaimer.

4. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation and/
or other materials provided with the distribution.

5. The names “North Carolina State University”, “NCSU” and any trade‐name,
personal name, trademark, trade device, service mark, symbol, image, icon, or 
any abbreviation, contraction or simulation thereof owned by North Carolina 
State University must not be used to endorse or promote products derived from 
this software without prior written permission. For written permission, please
contact trademarks@ncsu.edu.

Disclaimer: THIS SOFTWARE IS PROVIDED “AS IS” AND ANY EXPRESSED OR IMPLIED 
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO 
EVENT SHALL THE APACHE SOFTWARE FOUNDATION OR ITS CONTRIBUTORS BE LIABLE FOR 
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON 
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (
INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------
Authors: Arash Dehghan Banadaki (adehgha@ncsu.edu)
         Srikanth Patala        (spatala@ncsu.edu)
--------------------------------------------------------------------------------
How to Cite:
Banadaki AD, Maldonis JJ, Voyles PM, Patala S. Point-Pattern Matching Technique
for Local Structural Analysis in Condensed Matter. arXiv preprint arXiv:1811.06098.
2018 Nov 14. https://arxiv.org/abs/1811.06098v2
--------------------------------------------------------------------------------
This package is inspired by McAuley and Caetano's work 
(http://cseweb.ucsd.edu/~jmcauley/pdfs/pr11.pdf) and has been 
extended and modified for 3D point matching.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

#include "nograph.hpp"
using namespace nograph;
using namespace Eigen;
// -----------------------------------------------------------------------


Scalar dist(Point a, Point b)
{
  return sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y)+ (a.z-b.z)*(a.z-b.z));
}
// -----------------------------------------------------------------------


Scalar magnitude(Point a)
{
  return sqrt(a.x*a.x + a.y*a.y+ a.z*a.z);
}
// -----------------------------------------------------------------------


Eigen::Matrix3d basis_finder_3d(Point a, Point b, Point c)
{
  Point ba = b - a;
  Point ca = c - a;
  // Constructing a 3D orthonormal basis
  Eigen::Vector3d ba_vec(ba.x,ba.y,ba.z);
  Eigen::Vector3d ca_vec(ca.x,ca.y,ca.z);
  Eigen::Vector3d abc_norm_vec = ba_vec.cross(ca_vec);
  Eigen::Vector3d ba_norm_vec = ba_vec.cross(abc_norm_vec);
  ba_vec.normalize();
  abc_norm_vec.normalize();
  ba_norm_vec.normalize();
  Eigen::Matrix3d basis(3,3);
  basis.col(0) = ba_vec;
  basis.col(1) = abc_norm_vec;
  basis.col(2) = ba_norm_vec;
  if (basis.determinant()<0){
      basis.col(1) = ba_norm_vec;
      basis.col(2) = abc_norm_vec;
      std::cout<<"the obtained basis was not right handed. column 2 and 3 were swapped!"<<std::endl;
  }

  return basis;
}
// -----------------------------------------------------------------------


Eigen::Matrix3d basis_finder_3d_nonorth(Point a, Point b, Point c)
{
  Point ba = b - a;
  Point ca = c - a;
  // Constructing a 3D orthonormal basis
  Eigen::Vector3d ba_vec(ba.x,ba.y,ba.z);
  Eigen::Vector3d ca_vec(ca.x,ca.y,ca.z);
  Eigen::Vector3d abc_norm_vec = ba_vec.cross(ca_vec);
  ba_vec.normalize();
  ca_vec.normalize();
  abc_norm_vec.normalize();
  Eigen::Matrix3d basis(3,3);
  basis.col(0) = ba_vec;
  basis.col(1) = ca_vec;
  basis.col(2) = abc_norm_vec;
  if (basis.determinant()<0){
      basis.col(0) = ca_vec;
      basis.col(1) = ba_vec;
  }

  return basis;
}
// -----------------------------------------------------------------------


//----Added by Arash: finds the location of point D in the target based on the pattern extracted from the ABCD tetrahedron in the model----//
Point find_point_c_in_target(Point A_in_target, Eigen::Matrix3d basis_3d_target, Eigen::Matrix3d basis_3d_model, Point da_model)
{
  Eigen::Matrix3d l_po_model_po_target = (basis_3d_target) * (basis_3d_model.inverse());

  Eigen::Vector3d da_model_eigen(da_model.x, da_model.y, da_model.z);
  Eigen::Vector3d da_model_in_target_eigen = l_po_model_po_target * da_model_eigen;
  Point da_model_in_target;
  da_model_in_target.x = da_model_in_target_eigen(0);
  da_model_in_target.y = da_model_in_target_eigen(1);
  da_model_in_target.z = da_model_in_target_eigen(2);
  Point r3 = A_in_target + da_model_in_target;
  return r3;
}
// -----------------------------------------------------------------------


void search(Point A, ANNkd_tree* kdtree, int* ind0, int* ind1, int k,
	    Eigen::Matrix3d basis_3d_model, Eigen::Matrix3d basis_3d_target, Point da_model)
//This function finds the n (n = indo0 or ind1) nearest neighbors of the point r1 = A + unit_vector_along_the_BA in both directions.
//If ind0 is specified then it goes out from B toward A, else it comes in towards B equal to one unit vector length of BA.
{

  double* query = new double [2];
  ANNdistArray dists = new ANNdist [k];
  if (ind0 != NULL)
    {
      //--------------------Arash
      Point r1 = find_point_c_in_target(A, basis_3d_target, basis_3d_model, da_model);
      //--------------------

      query[0] = r1.x;
      query[1] = r1.y;
      query[2] = r1.z;

      /** ind0 gets changed after being passed to this function. ind0[i]=j where i is
       *  the ranking among k closest neighbors and j is the index# in the tree*/
      //      kdtree->annkSearch(query, k, ind0, dists, r1.dist(A));
      kdtree->annkSearch(query, k, ind0, dists, dist(r1, A));
    }

  if (ind1 != NULL)
    {
      //--------------------Arash
      basis_3d_model.col(2)= - basis_3d_model.col(2);
      Point r2 = find_point_c_in_target(A, basis_3d_target, basis_3d_model, da_model);
      //--------------------


      query[0] = r2.x;
      query[1] = r2.y;
      query[2] = r2.z;
      /** one reason for using this large of a radius (i.e. r2.dist(A)) is
       * because annkSearch based on the manual is a brute force method
       * and may not be accurate. It also DOES NOT sort the neighbors based
       * on their distances from the query point. However it is a compromise
       * between the speed and accuracy to use more accurate methods (e.g.
       * annkPriSearch). The performance of the algo must be checked with
       * such search algos as it cleans up the code.  */
      //      kdtree->annkSearch(query, k, ind1, dists, r2.dist(A));
      kdtree->annkSearch(query, k, ind1, dists, dist(r2, A));
    }

  delete [] query;
  delete [] dists;

  return;
}
// -----------------------------------------------------------------------


double nc2_wij(vector<double>* w, int n)
{
    double sum_wij = 0.0;
    for (int i = 1; i < n+1; i++)
      {
	for (int j = i+1; j < n+1; j++)
	  {
	    sum_wij += w->at(i-1) * w->at(j-1) ;
	  }
      }
    return sum_wij;
}
// -----------------------------------------------------------------------


Graph::Graph(vector<Point>* scenepoints,
	     vector<Point>* searchpoints,
	     vector<double>* weights,
	     int k, bool nchoosek_cost) :

        					     scenepoints(scenepoints),
						     searchpoints(searchpoints),
						     weights(weights),
						     n((int) scenepoints->size()),
						     m((int) searchpoints->size()),
						     k(k)
{
  Scalar** points = new Scalar* [m];
  for (int i = 0; i < m; i ++)
    {
      points[i] = new Scalar [3];
      points[i][0] = searchpoints->at(i).x;
      points[i][1] = searchpoints->at(i).y;
      points[i][2] = searchpoints->at(i).z;
    }
  ANNpointArray dataPts = points;

  kdtree = new ANNkd_tree(dataPts, m, 3);

  match = new int [n];

  int* res0 = new int [n];
  int* res1 = new int [n];

  Scalar dumbcost = numeric_limits<Scalar>::max();
  Scalar bestcost = dumbcost;

  int* nearestindex0 = new int [k];
  int* nearestindex1 = new int [k];

  besta  = ANN_NULL_IDX;
  besta1 = ANN_NULL_IDX;
  besta2 = ANN_NULL_IDX;
  bestr  = ANN_NULL_IDX;

  double sum_wij = nc2_wij(weights, n);
  Scalar ba_mag = magnitude(scenepoints->at(1) - scenepoints->at(0));
  Scalar ca_mag = magnitude(scenepoints->at(2) - scenepoints->at(0));
  Scalar cb_mag = magnitude(scenepoints->at(2) - scenepoints->at(1));
  double ba_weight = (weights->at(1) * weights->at(0)) / sum_wij;
  double ca_weight = (weights->at(2) * weights->at(0)) / sum_wij;
  double cb_weight = (weights->at(2) * weights->at(1)) / sum_wij;

  Eigen::Matrix3d basis_3d_model = basis_finder_3d (scenepoints->at(0), scenepoints->at(1), scenepoints->at(2));

  vector<int> reorder;
  for (int i = 0; i < m; i ++) reorder.push_back(i);
  random_shuffle(reorder.begin(), reorder.end());

  for (int ap = 0; ap < m; ap ++)
    {
      int a = reorder[ap];
      for (int a1p = 0; a1p < m; a1p ++)
	{
	  int a1 = reorder[a1p];
	  if (a == a1) continue; //to select unique points as root points
	  for (int a2p = 0; a2p < m; a2p ++)
	    {
	      int a2 = reorder[a2p];
	      if (a==a2 or a1==a2) continue; //to select unique points as root points

	      /** The following is the initial cost associated with choosing ath a1th entry of searchpoints as the starting points.
	       * This cost is in fact the difference in distance between two seleclted points in target and the two root points in
	       * the model. For 3D case we have 3 root points and three edge length to comapre. */
/**	      Scalar currentcost0 = fabs(magnitude(searchpoints->at(a) - searchpoints->at(a1))    \
*					 + magnitude(searchpoints->at(a) - searchpoints->at(a2))  \
*					 + magnitude(searchpoints->at(a1) - searchpoints->at(a2)) \
*					 - ba_mag - ca_mag - cb_mag); */
	      Scalar currentcost0 = fabs(magnitude(searchpoints->at(a) - searchpoints->at(a1)) - ba_mag) * ba_weight;
	      currentcost0 +=	fabs(magnitude(searchpoints->at(a) - searchpoints->at(a2)) - ca_mag) * ca_weight;
	      currentcost0 +=	fabs(magnitude(searchpoints->at(a1) - searchpoints->at(a2)) - cb_mag) * cb_weight;

	      Scalar currentcost1 = currentcost0;
	      if (bestcost > 0 and currentcost0 > bestcost) continue;

	      res0[0] = a; res0[1] = a1; res0[2] = a2;
	      res1[0] = a; res1[1] = a1; res1[2] = a2;

	      //Arash
	      Eigen::Matrix3d basis_3d_target = basis_finder_3d (searchpoints->at(a), searchpoints->at(a1), searchpoints->at(a2));

	      for (int a3 = 3; a3 < n; a3 ++)
		{

		  Scalar da_mag = magnitude(scenepoints->at(a3) - scenepoints->at(0));
		  Scalar db_mag = magnitude(scenepoints->at(a3) - scenepoints->at(1));
		  Scalar dc_mag = magnitude(scenepoints->at(a3) - scenepoints->at(2));
		  double da_weight = (weights->at(a3) * weights->at(0)) / sum_wij;
		  double db_weight = (weights->at(a3) * weights->at(1)) / sum_wij;
		  double dc_weight = (weights->at(a3) * weights->at(2)) / sum_wij;

		  Point da_scene = scenepoints->at(a3) - scenepoints->at(0);


		  for (int i = 0; i < k; i ++) { nearestindex0[i] = ANN_NULL_IDX; nearestindex1[i] = ANN_NULL_IDX; }
		  if (currentcost0 < bestcost and currentcost1 < bestcost)
		    search(searchpoints->at(a), kdtree, nearestindex0, nearestindex1, k, basis_3d_model, basis_3d_target, da_scene);
		  else if (currentcost0 < bestcost)
		    search(searchpoints->at(a), kdtree, nearestindex0, NULL, k, basis_3d_model, basis_3d_target, da_scene);
		  else if (currentcost1 < bestcost)
		    search(searchpoints->at(a), kdtree, NULL, nearestindex1, k, basis_3d_model, basis_3d_target, da_scene);
		  else
		    break;

		  Scalar kcost0 = ANN_DIST_INF;
		  Scalar kcost1 = ANN_DIST_INF;
		  int bestk0 = ANN_NULL_IDX;
		  int bestk1 = ANN_NULL_IDX;

		  /** after nearestindex0 getting passed from the search function we check the best cost of nearest
		   * neighbors as the ANN library DOES NOT sort the neighbors based on the distances */
		  for (int i = 0; i < k; i ++)
		    {
		      if (nearestindex0[i] != ANN_NULL_IDX)
			{
			  Scalar c0 = fabs(magnitude(searchpoints->at(nearestindex0[i]) - searchpoints->at(a))  - da_mag) * da_weight;
			  c0 +=       fabs(magnitude(searchpoints->at(nearestindex0[i]) - searchpoints->at(a1)) - db_mag) * db_weight;
			  c0 +=       fabs(magnitude(searchpoints->at(nearestindex0[i]) - searchpoints->at(a2)) - dc_mag) * dc_weight;

			  /**---This section adds more edges to give the nchoosek cost.---**/
			  if (nchoosek_cost)
			    {
			      if (a3 > 3)
				{
				  for (int kk = 3; kk < a3; kk ++)
				    {
				      if (c0 > kcost0) break;
				      c0 += fabs(magnitude(searchpoints->at(res0[kk]) - searchpoints->at(nearestindex0[i]))  -
						 magnitude(scenepoints->at(kk) - scenepoints->at(a3))) * (weights->at(kk) * weights->at(a3)) / sum_wij;
				    }
				}
			    }
			  /**--------------------------------------------------------------------------**/

			  if (bestk0 == ANN_NULL_IDX or c0 < kcost0)
			    {
			      bestk0 = nearestindex0[i];
			      kcost0 = c0;
//			      printf("%d \n", bestk0);
			    }
			}
		      /** The same as the above loop just for the inverted scene points. */
		      if (nearestindex1[i] != ANN_NULL_IDX)
			{
			  Scalar c1 = fabs(magnitude(searchpoints->at(nearestindex1[i]) - searchpoints->at(a) ) - da_mag) * da_weight;
			  c1 +=       fabs(magnitude(searchpoints->at(nearestindex1[i]) - searchpoints->at(a1)) - db_mag) * db_weight;
			  c1 +=       fabs(magnitude(searchpoints->at(nearestindex1[i]) - searchpoints->at(a2)) - dc_mag) * dc_weight;

			  /**---This section adds the inter-node distances to find the accurate cost.---**/
			  if (nchoosek_cost)
			    {
			      if (a3 > 3)
				{
				  for (int kk = 3; kk < a3; kk ++)
				    {
				      if (c1 > kcost1) break;
				      c1 += fabs(magnitude(searchpoints->at(res1[kk]) - searchpoints->at(nearestindex1[i]))  -
						 magnitude(scenepoints->at(kk) - scenepoints->at(a3))) * (weights->at(kk) * weights->at(a3)) / sum_wij;
				    }
				}
			    }
			  /**--------------------------------------------------------------------------**/

			  if (bestk1 == ANN_NULL_IDX or c1 < kcost1)
			    {
			      bestk1 = nearestindex1[i];
			      kcost1 = c1;
			    }
			}
		    }


		  if (bestk0 != ANN_NULL_IDX)
		    {
		      currentcost0 += kcost0;
		      res0[a3] = bestk0;
		    }
		  if (bestk1 != ANN_NULL_IDX)
		    {
		      currentcost1 += kcost1;
		      res1[a3] = bestk1;
		    }
		}

	      if (currentcost0 < bestcost)
		{
		  besta = a;
		  besta1 = a1;
		  besta2 = a2;
		  bestr = 0;
		  bestcost = currentcost0;
		  memcpy(match, res0, n*sizeof(int));
		}
	    }
	}
    }

  delete [] res0;
  delete [] res1;
  delete [] nearestindex0;
  delete [] nearestindex1;
  for (int i = 0; i < m; i ++) delete [] points[i];
  delete [] points;
}
// -----------------------------------------------------------------------


void Graph::Propagate()
{
  // Nothing to do...
}
// -----------------------------------------------------------------------


int* Graph::MAPestimate()
{
  int* result = new int [n];
  memcpy(result, match, n*sizeof(int));
  return result;
}
// -----------------------------------------------------------------------
