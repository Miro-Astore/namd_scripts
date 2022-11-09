package require autoionize 

autoionize -psf solvate.psf -pdb solvate.pdb -sc 0.15 -cation POT -anion CLA -o ionized -from 5
exit
