#!/bin/bash

python -c 'import numpy as np; np.save ("coord",np.loadtxt("coord.raw" ).astype(np.float32))'
python -c 'import numpy as np; np.save ("box",np.loadtxt("box.raw" ).astype(np.float32))'

cat << EOF > wan.py
import numpy as np
w=np.loadtxt("wannier.raw" ).astype(np.float32)
t=np.loadtxt("type.raw").astype(np.float32)
t=t[t!=2]
w=w.reshape((w.shape[0],int(w.shape[1]/12),4,3))
w=np.sum(w,axis=2)
w/=4. 
w=w.reshape((w.shape[0],-1))
np.save("atomic_dipole",w)
EOF
python wan.py
rm wan.py

mkdir set.000
mv *npy set.000

