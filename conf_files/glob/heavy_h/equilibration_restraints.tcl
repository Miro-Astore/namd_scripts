mol new ionized.psf
mol addfile out_eq0.restart.coor


set all [atomselect top "all"]
$all set beta 0.0
$all set beta 0.0

set bb [atomselect top "protein"]
$bb set beta 10.0

$all writepdb refumb.pdb
exit
