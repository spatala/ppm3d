ppm3d:
=============
**ppm3d** is a 3D Point Pattern Matching package that is designed to find the closest match for a given 3D motif in a 3D point cloud. It is written in C++ and ships with a python wrapper.
                
.. image:: https://github.com/adehgha/Animations/blob/master/ppm3d_animation.gif
        
* ppm3d on `GitHub <https://github.com/spatala/ppm3d>`__


Introduction:
=============
This software is the implementation of the 3D point pattern matching algorithm that has been published in the following article. Please cite the following article if you use this algorithm in your research. Contact the NCSU (refer to the provided license) for commercial use.

`Banadaki AD, Maldonis JJ, Voyles PM, Patala S., "Point-Pattern Matching Technique for Local Structural Analysis in Condensed Matter", arXiv preprint arXiv:1811.06098. 2018 Nov 14. <https://arxiv.org/abs/1811.06098v2>`__


Installation:
==========
If you are on a debian based OS, or Ubuntu, the repository ships with the compiled shared library(``point_match.so``). On other linux distributions you will need to compile the package. For other OS contact the authors.

1.  **Clone the ppm3d repository from github:**      
    
    .. code-block:: console
                
        $ git clone https://github.com/spatala/ppm3d


Compilation:
==========
To compile the ``ppm3d`` package:

1.  **Clone the ppm3d repository from github:**      
    
    .. code-block:: console
                
        $ git clone https://github.com/spatala/ppm3d

2.  **Change your current directory to ppm3d:**      
    
    .. code-block:: console
                
        $ cd /ppm3d_repo_path/ppm3d
        
3.  **Clean the original build:**      
    
    .. code-block:: console
                
        $ make clean

4.  **Build the Repository:** Contact the authors for use on mac and Windows.      
    
    .. code-block:: console
                
        $ make

5.  **Check the compilation:** Up on successful compilation a shared library file named "point_match.so" will be created in this folder.
    
6.  **Add ppm3d to you path:** if you are using bash:      
    
    .. code-block:: console
                
        $ export PATH=/ppm3d_repo_path/ppm3d:$PATH
        $ export PYTHONPATH="${PYTHONPATH}:/ppm3d_repo_path/ppm3d"
     
        
How to Use This Package:
========================
.. 1.  **To install the stable version of GBpy:**              	

..     .. code-block:: console     
           
..         $ python setup.py install
                   
.. 1.  **Import the package:** 
                
..     .. code-block:: pycon
                
..         >>> import ppm3d
                          
1.  **Call the** ``find_map`` **function from pppm3d.py to find a given set of points (model) in a 3d point target:**
                
    .. code-block:: pycon
                
        >>> ppm3d.find_map(model, target, 3, True, weights)


2.  **Call the** ``absor`` **function to align the mapped target to the model:**
                
    .. code-block:: pycon
                
        >>> ppm3d.absor(model, target, False, weights)        
                

3.  **Call the** ``align_polys`` **function to perform the steps 1 and 2, combined:**
                
    .. code-block:: pycon
                
        >>> rmsd_error, failure_flag, alignment_attributes = ppm3d.align_polys((model, target, model_weights, target_weights))      


Consult the `documentation <https://cdn.rawgit.com/adehgha/>`__ for further details.
        
        
Prerequisites:
==============

1. install ``GNU Compilers`` from `here. <https://gcc.gnu.org/>`__

2. install ``python`` from `here. <http://www.python.org/>`__

3. install ``numpy`` from `here. <http://www.numpy.org/>`__
                
4. install ``setuptools`` from `here. <https://pypi.python.org/pypi/setuptools>`__
   

Cite ppm3d:
========================

`Banadaki AD, Maldonis JJ, Voyles PM, Patala S., "Point-Pattern Matching Technique for Local Structural Analysis in Condensed Matter", arXiv preprint arXiv:1811.06098. 2018 Nov 14. <https://arxiv.org/abs/1811.06098v2>`__

                
Credits:
========
ppm3d is written by:

* `Arash Dehghan Banadaki <adehgha@ncsu.edu>`__                
* `Srikanth Patala <spatala@ncsu.edu>`__
* `Patala Research Group <http://research.mse.ncsu.edu/patala/>`__.
        
Copyright (c) 2018,  Arash Dehghan Banadaki and Srikanth Patala.
