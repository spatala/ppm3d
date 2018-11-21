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

#include "experiment.hpp"
#include "../ann_1.1.2/include/ANN/ANN.h"
#include "common.hpp"
#include "nograph.hpp"

// -----------------------------------------------------------------------
int* runone(int choice, vector<Point>* p1, vector<Point>* p2, vector<double>* weights_init, Scalar* setup, Scalar* prop, Scalar* total, Scalar* perf, int k, int loss, bool nchoosek_cost)
{
  void* Graph = NULL;
  clock_t start = clock();
  clock_t start2 = start;

  vector<Point> p1p = *p1;
  vector<double> weights = *weights_init;

  int* correctmatch = new int [(int) p1p.size()];
  for (int i = 0; i < (int) p1p.size(); i ++) correctmatch[i] = i;

  int furthest1 = ANN_NULL_IDX;
  int furthest2 = ANN_NULL_IDX;
  Scalar furthest = 0;

  for (int i = 0; i < (int) p1p.size(); i ++)
    for (int j = 0; j < (int) p1p.size(); j ++)
    {
      Scalar dist = p1p[i].dist(p1p[j]);
      if (dist > furthest)
      {
        furthest1 = i;
        furthest2 = j;
        furthest = dist;
      }
    }
  Point temp;
  int temp2;
  temp = p1p[0];
  p1p[0] = p1p[furthest1];
  p1p[furthest1] = temp;

  temp2 = correctmatch[0];
  correctmatch[0] = furthest1;
  correctmatch[furthest1] = temp2;

  double temp_weight = weights[0];
  weights[0] = weights[furthest1];
  weights[furthest1] = temp_weight;


  temp = p1p[1];
  p1p[1] = p1p[furthest2];
  p1p[furthest2] = temp;

  temp2 = correctmatch[1];
  correctmatch[1] = furthest2;
  correctmatch[furthest2] = temp2;

  temp_weight = weights[1];
  weights[1] = weights[furthest2];
  weights[furthest2] = temp_weight;


  if (choice == NOGRAPH) Graph = (void*) new nograph::Graph(&p1p, p2, &weights, k, nchoosek_cost);

  *setup = (clock() - start2)/ (double) CLOCKS_PER_SEC;

  start2 = clock();

  *prop = (clock() - start2)/ (double) CLOCKS_PER_SEC;

  int* res = NULL;

  if (choice == NOGRAPH)  res = ((nograph::Graph*) Graph)->MAPestimate();

  if (loss == HAMMING)
  {
    int correct = 0;
    for (int i = 0; i < (int) p1p.size(); i ++) if (res[i] == correctmatch[i]) correct ++;
    *perf = 1.0 - correct / (double) p1p.size();
  }
  else // loss == ENDPOINT
  {
    Scalar ee = 0;
    for (int i = 0; i < (int) p1p.size(); i ++) ee += p2->at(correctmatch[i]).dist(p2->at(res[i]));
    *perf = ee / (double) p1p.size();
  }

  *total = (clock() - start)/ (double) CLOCKS_PER_SEC;

  if (choice == NOGRAPH)                    delete ((nograph::Graph*) Graph);

  delete [] correctmatch;
  
  // Undo the swap we did previously
  int temp3;
  temp3 = res[1];
  res[1] = res[furthest2];
  res[furthest2] = temp3;
  // ----
  temp3 = res[0];
  res[0] = res[furthest1];
  res[furthest1] = temp3;
  // Arash: The order of swapping was wrong and would cause issues 
  // if the first two vertices had to be swapped.
  // temp3 = res[1]; 
  // res[1] = res[furthest2];
  // res[furthest2] = temp3;
  return res;
}
// -----------------------------------------------------------------------
vector<Point>* loadone(char* name)
{
  FILE* hfile = fopen(name, "r");
  vector<Point>* ps = new vector<Point>();
  while (true)
  {
    float x;
    float y;
    float z;
    if (fscanf(hfile, "%f %f %f", &x, &y, &z) != 3) break;
    ps->push_back(Point(x,y,z));
  }
  fclose(hfile);
  return ps;
}
// -----------------------------------------------------------------------
/**
 * Take two sets of points, and return the best correspondence from points in the first file to points in the second.
 * The first graph should typically be the *smaller* of the two.
 * 
 * The third term (k) is the number of nearest neighbors to use. Set it to ~5 for reasonable performance.
 */
//int* runFromFiles(char* path1, char* path2, int k)
int* runFromFiles(vector<Point>* ps1, vector<Point>* ps2, vector<double>* weights , int k, bool nchoosek_cost)
{
//  clock_t start = clock();
//  clock_t start2 = start;

  Scalar setup, prop, total, perf;
  int* res = runone(NOGRAPH, ps1, ps2, weights, &setup, &prop, &total, &perf, k, HAMMING, nchoosek_cost);
//  -------------------------------------------Arash weights
  
//  Scalar run_time = (clock() - start2)/ (double) CLOCKS_PER_SEC;
//  std::cout<<"run time (sec):" << run_time << std::endl;

  return res;
}
// -----------------------------------------------------------------------
Scalar uniform(Scalar scale)
{
  return (scale*rand()) / (RAND_MAX+1.0);
}
// -----------------------------------------------------------------------
Point transform(Point p)
{
  static Scalar x_t = uniform(1000);
  static Scalar y_t = uniform(1000);
  static Scalar theta = uniform(2*Pi);
  static int reflect = rand()%2;

  Point ptemp = p;
  Point res = p;

  if (reflect)
  {
    ptemp.x = -p.x;
    res.x = ptemp.x;
  }

  res.x = cos(theta)*ptemp.x + sin(theta)*ptemp.y;
  res.y = -sin(theta)*ptemp.x + cos(theta)*ptemp.y;
  res.x += x_t;
  res.y += y_t;
  return res;
}
// -----------------------------------------------------------------------
bool pointsort(Point p1, Point p2) { return p1.x < p2.x; }
// -----------------------------------------------------------------------
