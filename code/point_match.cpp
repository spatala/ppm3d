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

#include "common.hpp"
#include "nograph.hpp"
#include "experiment.hpp"
#include <iostream>
#include <fstream>
#include <string.h>
using namespace std;

 // -----------------------------------------------------------------------
vector<Point>* load_2dnumpy_to_vector(double *numpy_2d_array, int num_rows)
{
  vector<Point>* ps = new vector<Point>();
  for (int i = 0; i < num_rows; i ++){ 
  	// for row based memory reference e.g. python, c, etc.
    ps->push_back(Point(numpy_2d_array[i*3], numpy_2d_array[i*3+1], numpy_2d_array[i*3+2])); 
  }
  return ps;
}

// -----------------------------------------------------------------------
vector<double>* load_1dnumpy_to_vector(double *numpy_1d_array, int num_elems)
{
 vector<double>* ps = new vector<double>();
 for (int i = 0; i < num_elems; i ++){
   // for row based memory reference e.g. python, c, etc.
     ps->push_back(numpy_1d_array[i]);
 }
 return ps;
}

 // -----------------------------------------------------------------------
extern "C" {
int* point_match(double *model, int m, double *target, int t, double *weights_np, int k, int * outMatrix, bool one_to_one_switch)
{
	vector<Point>* ps1 = load_2dnumpy_to_vector(model, m);
	vector<Point>* ps2 = load_2dnumpy_to_vector(target, t);
	vector<double>* weights = load_1dnumpy_to_vector(weights_np, m);
	
	// printf("PR'11, k=%d:\n", k); 
	int* a = runFromFiles(ps1, ps2, weights, k, one_to_one_switch);
	for (int i=0; i< m; i++)
	{
	    outMatrix[i] = a[i]+1;
	}
	delete(ps1); delete(ps2); delete(weights); 
 	return outMatrix;
}
}
// -----------------------------------------------------------------------
