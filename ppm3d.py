# -*- coding: utf-8 -*-
"""----------------------------------------------------------------
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
@author: Arash Dehghan Banadaki (adehgha@ncsu.edu),
         Srikanth Patala        (spatala@ncsu.edu)
--------------------------------------------------------------------------------
How to Cite:
Banadaki AD, Maldonis JJ, Voyles PM, Patala S. Point-Pattern Matching Technique
for Local Structural Analysis in Condensed Matter. arXiv preprint arXiv:1811.06098.
2018 Nov 14. https://arxiv.org/abs/1811.06098v2
--------------------------------------------------------------------------------
The ppm3d is inspired by McAuley and Caetano's work 
(http://cseweb.ucsd.edu/~jmcauley/pdfs/pr11.pdf) and has been 
extended and modified for 3D point matching.
--------------------------------------------------------------------------------
The absor function is based on the Berthold K.P. Horn's work 
(http://people.csail.mit.edu/bkph/papers/Absolute_Orientation.pdf) and is the 
conversion of its Matlab implementation Matt Jacobson (see the link below).
(http://www.mathworks.com/matlabcentral/fileexchange/26186-absolute-orientation-horn-s-method)
--------------------------------------------------------------------------------
The Wrapper Function for the 3d point pattern matching software (ppm3d) is written 
by Arash Dehghan Banadaki using the ctypes and is subjected to the terms provided
in the license file. Please follow the documentation to use this package.
--------------------------------------------------------------------------------"""


import ctypes
import numpy as np
import numpy.ctypeslib as npct
from itertools import combinations
# --------------------------------------------------------------------------------


def find_map(model, target, k=3, n_choosek_flag=True, weights=None):
    model = np.array(model, np.float)
    target = np.array(target, np.float)
    output_map = np.zeros((model.shape[0],), dtype=np.int)
    if weights is None:
        weights = np.ones((model.shape[0],), dtype=np.float)
    else:
        weights = np.array(weights, np.float)

    libm = np.ctypeslib.load_library('point_match.so', '.')

    # input type ppm3d function
    # must be a double array, with single dimension that is contiguous
    array_1d_double = npct.ndpointer(dtype=np.double, ndim=1, flags='CONTIGUOUS')
    array_1d_integer = npct.ndpointer(dtype=np.integer, ndim=1, flags='CONTIGUOUS')
    array_2d_double = npct.ndpointer(dtype=np.double, ndim=2, flags='CONTIGUOUS')

    # setup the return types and argument types
    libm.point_match.argtypes = [array_2d_double, ctypes.c_int, array_2d_double, ctypes.c_int, array_1d_double, ctypes.c_int, array_1d_integer, ctypes.c_bool]
    libm.point_match.restype = np.ctypeslib.ndpointer(dtype=ctypes.c_int, shape=(model.shape[0],))
    output_map1 = libm.point_match(model, model.shape[0], target, target.shape[0], weights, k, output_map, n_choosek_flag)

    return output_map1
# --------------------------------------------------------------------------------


def absor(A, B, do_scale=False, weight=None):
    A = np.array(A.T, dtype=float)
    B = np.array(B.T, dtype=float)
    in_dim = len(A)
    if A.shape[1] != B.shape[1]:
        print 'The number of points to be registered must be the same'
        raise
    if weight is None:
        sumwts = 1

        lc = np.mean(A, axis=1)
        rc = np.mean(B, axis=1)  # Centroids
        left = A - lc.reshape(in_dim, 1)  # Center coordinates at centroids
        right = B - rc.reshape(in_dim, 1)
    else:
        weights = np.array(weight, dtype=float).reshape(A.shape[1], 1)
        sumwts = np.sum(weights)
        weights = abs(weights) / sumwts
        sqrtwts = np.sqrt(weights).reshape(1, A.shape[1])

        lc = np.dot(A, weights).T
        rc = np.dot(B, weights).T # weighted centroids

        left = A - lc.T
        left = left * sqrtwts
        right = B - rc.T
        right = right * sqrtwts
    # ----------------------------------
    M = np.dot(left, right.T)
    # #######Compute rotation matrix
    if in_dim == 2:
        Nxx = M[0, 0] + M[1, 1]
        Nyx = M[0, 1] - M[1, 0]

        N = np.array([[Nxx, Nyx], [Nyx, -Nxx]])
        D, V = np.linalg.eig(N)
        emax = np.argmax(np.real(V))
        q = np.real(V[:, emax])  # %Gets eigenvector corresponding to maximum eigenvalue
        # q = real(q)  #%Get rid of imaginary part caused by numerical error

        if q[1] >= 0:
            q1 = 1
        q = q * np.sign(q[1] + q1)  # Sign ambiguity
        q /= np.linalg.norm(q)

        R11 = q[0] ** 2 - q[1] ** 2
        R21 = np.prod(q) * 2
        R = np.array([[R11, -R21], [R21, R11]])  # %map to orthogonal matrix
    elif in_dim == 3:
        Sxx = M[0, 0]
        Syx = M[1, 0]
        Szx = M[2, 0]
        Sxy = M[0, 1]
        Syy = M[1, 1]
        Szy = M[2, 1]
        Sxz = M[0, 2]
        Syz = M[1, 2]
        Szz = M[2, 2]

        N = np.array([[(Sxx + Syy + Szz), (Syz - Szy), (Szx - Sxz), (Sxy - Syx)],
                      [(Syz - Szy), (Sxx - Syy - Szz), (Sxy + Syx), (Szx + Sxz)],
                      [(Szx - Sxz), (Sxy + Syx), (-Sxx + Syy - Szz), (Syz + Szy)],
                      [(Sxy - Syx), (Szx + Sxz), (Syz + Szy), (-Sxx - Syy + Szz)]])

        # ------------------------------
        D, V = np.linalg.eig(N)
        # ------------------------------
        # from oct2py import octave
        # D,V = octave.eig(N)
        # ------------------------------
        # import scipy.linalg as scp_lalg
        # D,V = scp_lalg.eigh(N)
        # D, V1, V = scp_lalg.eig(N, left=True, right=True)
        # ------------------------------
        emax = np.argmax(np.real(D))
        q = np.real(V[:, emax])
        ii = np.argmax(abs(q))
        sgn = np.sign(q[ii])
        q = q * sgn  # Sign ambiguity

        quat = q[:]
        nrm = np.linalg.norm(quat)
        if not nrm:
            raise 'Quaternion distribution is 0'

        quat /= nrm

        q0 = quat[0]
        qx = quat[1]
        qy = quat[2]
        qz = quat[3]
        v = quat[1:4]

        Z = np.array([[q0, -qz, qy],
                      [qz, q0, -qx],
                      [-qy, qx, q0]])

        R = v.reshape(in_dim, 1) * v + np.dot(Z, Z)

    else:
        raise 'Points must be either 2D or 3D'

    if do_scale:
        sss = np.sum(right * np.dot(R, left)) / np.sum(np.square(left))
        t = rc - np.dot(R, (lc * sss).T).T
    else:
        sss = 1
        t = rc - np.dot(R, lc.reshape(in_dim, 1)).T[0]
    if in_dim == 2:
        regParams = {'R': R, 't': t, 's': sss,
                     'M': np.vstack(([np.hstack((sss * R, t.reshape(in_dim, 1))), [0, 0, 1]])),
                     'theta': np.arctan2(q[1], q[0]) * 360 / np.pi}
    else:
        regParams = {'R': R, 't': t, 's': sss,
                     'M': np.vstack(([np.hstack((sss * R, t.reshape(in_dim, 1))), [0, 0, 0, 1]])),
                     'q': q / np.linalg.norm(q)}
    Bfit = np.dot((sss * R), A) + t.reshape(in_dim, 1)
    err = np.sqrt(np.sum(np.square(Bfit - B), axis=0))
    if weight is not None:
        err = err * sqrtwts
    ErrorStats = {'errlsq': np.linalg.norm(err) * np.sqrt(sumwts), 'errmax': max(err)}
    return regParams, Bfit.T, ErrorStats
# --------------------------------------------------------------------------------


def align_polys((model, original_target, weights_m, weights_t)):
    # ------ Same number of vertices in model and target ------
    if model.shape[0] == original_target.shape[0]:
        absor_error_1, fail_flag_1, align_attr_1 = align_polys_model_vs_target(model, original_target, weights_m, weights_t)
        absor_error_2, fail_flag_2, align_attr_2 = align_polys_model_vs_target(original_target, model, weights_t, weights_m)
        if absor_error_1 < absor_error_2:
            absor_error = absor_error_1; fail_flag = fail_flag_1; align_attr = align_attr_1;
        else:
            absor_error = absor_error_2; fail_flag = fail_flag_2; align_attr = align_attr_2;
    # ------ Number of vertices in model less than target ------
    else:
        absor_error, fail_flag, align_attr = align_polys_model_vs_target(model, original_target, weights_m, weights_t)

    return absor_error, fail_flag, align_attr
# --------------------------------------------------------------------------------


def align_polys_model_vs_target(model, original_target, weights_m, weights_t):
    # ------ direct alignment ------
    ind_dir = find_map(model, original_target, 3, True, weights_m)
    T_dir_m, aligned_target_dir_m, err_dir_m = absor(original_target[ind_dir-1, :], model, False, weights_m)
    T_dir_t, aligned_target_dir_t, err_dir_t = absor(model, original_target[ind_dir-1, :], False, weights_t[ind_dir-1])
    if err_dir_m['errlsq'] < err_dir_t['errlsq']:
        T_dir = T_dir_m;    aligned_target_dir = aligned_target_dir_m;  err_dir = err_dir_m
    else:
        T_dir = T_dir_t;    aligned_target_dir = aligned_target_dir_t;  err_dir = err_dir_t
    # ------ inverse alignment ------
    ind_inv = find_map(model, -original_target, 3 , True, weights_m)
    T_inv_m, aligned_target_inv_m, err_inv_m = absor(-original_target[ind_inv-1, :], model, False, weights_m)
    T_inv_t, aligned_target_inv_t, err_inv_t = absor(model, -original_target[ind_inv-1, :], False, weights_t[ind_inv-1])
    if err_inv_m['errlsq'] < err_inv_t['errlsq']:
        T_inv = T_inv_m;    aligned_target_inv = aligned_target_inv_m;  err_inv = err_inv_m
    else:
        T_inv = T_inv_t;    aligned_target_inv = aligned_target_inv_t;  err_inv = err_inv_t

    align_attr = {'ind': [], 'aligned_target': [], 'T': [], 'err': []}
    if err_dir['errlsq'] < err_inv['errlsq']:
        absor_error = err_dir['errlsq']
        # nc2_cost = best_cost_func(model, aligned_target_dir)
        nc2_cost = 0
        align_attr['ind'] = ind_dir
        align_attr['aligned_target'] = aligned_target_dir
        align_attr['T'] = T_dir
        align_attr['err'] = err_dir
    else:
        absor_error = err_inv['errlsq']
        # nc2_cost = best_cost_func(model, aligned_target_inv)
        nc2_cost = 0
        align_attr['ind'] = ind_inv
        align_attr['aligned_target'] = aligned_target_inv
        align_attr['T'] = T_inv
        align_attr['err'] = err_inv

    fail_flag = False
    if (len(np.unique(ind_dir)) != len(ind_dir)) or (len(np.unique(ind_inv)) != len(ind_inv)):
        fail_flag = True

    return absor_error, fail_flag, align_attr
    # return absor_error, nc2_cost, fail_flag
# --------------------------------------------------------------------------------


def best_cost_func(model, b_fit):
    edge_list = np.array(list(combinations(range(model.shape[0]), 2)))
    # edge_list = nchoosek(1:size(model, 1), 2)
    model_edges = model[edge_list[:, 0], :] - model[edge_list[:, 1], :]
    target_edges = b_fit[edge_list[:, 0], :] - b_fit[edge_list[:, 1], :]
    model_edge_length = np.sqrt(model_edges[:, 0]**2 + model_edges[:, 1]**2 + model_edges[:, 2]**2)
    target_edge_length = np.sqrt(target_edges[:, 0]**2 + target_edges[:, 1]**2 + target_edges[:, 2]**2)
    cost = sum(abs(model_edge_length-target_edge_length)) / edge_list.shape[0]
    return cost
# --------------------------------------------------------------------------------
#if __name__=='__main__':
# model = np.array([[4, 5, 6],[1.2, 2, 3], [8, 9, 10], [7, 8, 10]], np.float)
# target = np.array([[1, 2, 3], [4, 5, 6], [8, 9, 10], [7, 8, 10]], np.float)
# w = np.ones((model.shape[0]))
# import time
# for i in range(10000000):
    # start = time.clock()
    # x = find_map(model, target, 3, True, w)
    # x,y,z = align_polys((model, target, w, w))
    # print x,y,z
    # a,b,c = absor(target, model)
    # print time.clock()-start
