# Basic setup

variable        simname index BAs
variable        t   equal 300
log 			log.${simname}.txt
units           metal
boundary		p p p
timestep 		0.001
atom_style      atomic

# Structure
read_data       ${simname}.data
region		lfixed    	block INF INF INF 9.57762 INF INF
group		glfixed    	region lfixed
region		rfixed    	block INF INF 279.57762 INF INF INF
group		grfixed    	region rfixed
group		gfixed    	union glfixed grfixed
region		tlow      	block INF INF 9.57762 29.57762 INF INF
region		thigh	   	block INF INF 259.57762 279.57762 INF INF
group		gthigh	   	region thigh	   		
group		gtlow	   	region tlow
group		innt      	subtract all gfixed 
group		innernt   	subtract all gfixed gthigh gtlow

region		block1		block INF INF 29.57762 52.57762 INF INF 
region		block2		block INF INF 52.57762 75.57762 INF INF
region		block3		block INF INF 75.57762 98.57762 INF INF
region		block4		block INF INF 98.57762 121.57762 INF INF
region		block5		block INF INF 121.57762 144.57762 INF INF
region		block6		block INF INF 144.57762 167.57762 INF INF
region		block7		block INF INF 167.57762 190.57762 INF INF
region		block8		block INF INF 190.57762 213.57762 INF INF
region		block9		block INF INF 213.57762 236.57762 INF INF
region		block10		block INF INF 236.57762 259.57762 INF INF
group           gblock1     region block1
group           gblock2     region block2
group           gblock3     region block3
group           gblock4     region block4
group           gblock5     region block5
group           gblock6     region block6
group           gblock7     region block7
group           gblock8     region block8
group           gblock9     region block9
group           gblock10    region block10

# Potentials
mass            1  10.811   # B atom
mass            2  74.9216  # As atom
pair_style      mlip mlip.ini
pair_coeff      * * B As

# Output Setting
compute         hot_temp  	 gthigh  	temp 
compute         cold_temp 	 gtlow 		temp 
compute		innt_temp	 innt		temp 
compute         innernt_temp innernt 	temp  
compute         block1_temp  gblock1  	temp 
compute         block2_temp  gblock2  	temp 
compute         block3_temp  gblock3  	temp 
compute         block4_temp  gblock4  	temp 
compute         block5_temp  gblock5  	temp 
compute         block6_temp  gblock6  	temp 
compute         block7_temp  gblock7  	temp 
compute         block8_temp  gblock8  	temp 
compute         block9_temp  gblock9  	temp 
compute         block10_temp  gblock10  temp 

compute 	    ke innernt ke/atom
compute 	    pe innernt pe/atom
compute 	    stress innernt centroid/stress/atom NULL virial
compute 	    flux innernt heat/flux ke pe stress

neighbor        2.0 bin
neigh_modify    delay 0 every 1

# energy minimize
dump            dem all atom 500 em.${simname}.lammpstrj
dump_modify     dem sort id
min_style       cg
minimize        0.0 1e-12 5000 10000
write_data      ${simname}_em.data
undump          dem
change_box		all boundary p f p

# equilibration run
reset_timestep  0
thermo          1000
thermo_style 	custom step etotal pxx pyy pzz 
dump            d1 all atom 10000 ${simname}_relaxation.lammpstrj
dump_modify     d1 sort id
velocity	    gfixed  set 0.0	0.0 0.0	
fix		        1 gfixed setforce 0.0 0.0 0.0
velocity 	    innt create 300 1024 rot yes dist gaussian
fix 		    2 innt nvt temp 300 300 0.1
run				200000
velocity        all scale $t
unfix			2

# thermal conductivity calculation
undump          d1
reset_timestep  0
dump            d2 all atom 10000 ${simname}_product.lammpstrj
dump_modify     d2 sort id
fix     	    3 innt nve
fix         	hot1 gthigh langevin 330 330 0.1 59804 tally yes
fix         	cold1 gtlow  langevin 270 270 0.1 287859 tally yes
fix 		    4 all ave/time 10 100 1000 f_hot1 f_cold1 c_block1_temp c_block2_temp c_block3_temp c_block4_temp c_block5_temp c_block6_temp c_block7_temp c_block8_temp c_block9_temp c_block10_temp file compute_Energy_Temp.out    
fix 		    5 all ave/time 10 100 1000 c_flux[1] c_flux[2] c_flux[3] c_flux[4] c_flux[5] c_flux[6] file compute_HeatFlux.out 
thermo_style 	custom step etotal c_innernt_temp c_hot_temp c_cold_temp f_hot1 f_cold1  
run             2000000        
