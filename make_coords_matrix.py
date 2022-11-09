# USAGE python namd_scripts//make_coords_martix.py pdbfile.pdb
import numpy as np
import sys
import MDAnalysis as mda

pdb = str(sys.argv[-1] )
u = mda.Universe (pdb)

all_sel = u.select_atoms('all')
x = all_sel.positions[:,0]
y = all_sel.positions[:,1]
z = all_sel.positions[:,2]

x_min = np.amin(x)
x_max = np.amax(x)
y_min = np.amin(y)
y_max = np.amax(y)
z_min = np.amin(z)
z_max = np.amax(z)

x_len = np.int(np.ceil(x_max - x_min))
y_len = np.int(np.ceil(y_max - y_min))
z_len = np.int(np.ceil(z_max - z_min))

boxsize = [x_len, y_len, z_len ]

origin =  ((all_sel.atoms.center_of_mass())) * 10  # conversion to Angstrom

print ("cellBasisVector1		{}	0	0".format(boxsize[0]))
print ("cellBasisVector2		0	{}	0".format(boxsize[1]))
print ("cellBasisVector3		0	0	{}".format(boxsize[2]))
print ("cellOrigin   " + str(origin[0]) + "    " + str(origin[1]) + "     "  + str(origin[2]))
