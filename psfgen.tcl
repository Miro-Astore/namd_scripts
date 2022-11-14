mol new ./apo_ph_domain.pdb
set sel [atomselect top "all"]
set segnames [$sel get chain]
set segnames [lsort -uniq $segnames]
puts [$segnames]
foreach seg $segnames { 
	set sel [atomselect top "chain $seg"]
	$sel set segname $seg
	$sel writepdb $seg\P1.pdb
}

package require psfgen 

resetpsf
topology /home/miro/Downloads/toppar/top_all36_prot.rtf
topology /home/miro/Downloads/toppar/top_all36_na.rtf
topology /home/miro/Downloads/toppar/stream/prot/toppar_all36_prot_na_combined.str

pdbalias ILE CD1 CD 
pdbalias residue HIS HSD
foreach seg $segnames { 
	segment $seg {
	auto angles dihedrals
		pdb $seg\P1.pdb
		first NTER 
		last CTER 
	}

	patch SP2 $seg:34 
	patch DISU $seg:60 $seg:77
	regenerate angles dihedrals
	#patch DISU $seg:297 $seg:311
	coordpdb $seg\P1.pdb $seg
}
guesscoord
hmassrepart
puts "writing"
writepsf out.psf
writepdb out.pdb

exit 
