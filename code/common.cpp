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
// -----------------------------------------------------------------------
// Distance between this point and another.
Scalar Point::dist(Point p)
{
  return sqrt((p.x-x)*(p.x-x) + (p.y-y)*(p.y-y)+ (p.z-z)*(p.z-z));
}

Scalar Point::magnitude()
{
  return sqrt(x*x + y*y+ z*z);
}
// -----------------------------------------------------------------------
Scalar distdiff(Point a1, Point a2, Point i1, Point i2)
{
  Scalar d1 = a1.dist(a2);
  Scalar d2 = i1.dist(i2);

  return -(d1-d2)*(d1-d2);
}
// -----------------------------------------------------------------------
Scalar sign(Scalar x)
{
  return (x > 0) ? 1 : ((x < 0) ? -1 : 0);
}
// -----------------------------------------------------------------------
bool scalarsort(Scalar s1, Scalar s2) { return s1 < s2; }
// -----------------------------------------------------------------------
Scalar median(Scalar* data, int n)
{
  vector<Scalar> s;
  for (int i = 0; i < n; i ++) s.push_back(data[i]);
  sort(s.begin(), s.end(), scalarsort);
  return s[n/2];
}
// -----------------------------------------------------------------------
Scalar mean(Scalar* data, int n)
{
  Scalar total = 0;
  for (int i = 0; i < n; i ++) total += data[i];
  return total/n;
}
// -----------------------------------------------------------------------
Scalar sde(Scalar* data, int n)
{
  Scalar avg = 0;
  Scalar avg2 = 0;

  for (int i = 0; i < n; i ++)
  {
    avg += data[i];
    avg2 += data[i]*data[i];
  }
  avg /= n;
  avg2 /= n;

  Scalar sd = 0;
  if (avg2 - avg*avg > 0) sd = sqrt(avg2 - avg*avg);
  return sd / sqrt((float) n);
}
// -----------------------------------------------------------------------