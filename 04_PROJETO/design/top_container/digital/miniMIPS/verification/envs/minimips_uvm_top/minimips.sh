#!/bin/sh

ENV_HOME=`dirname $0`
export ENV_HOME

usage() {
    echo "Usage:  minimips.sh [-batch]"
    echo ""
    echo "                ... all other Incisive Simulator/UVM options such as:"
    echo "                [+UVM_VERBOSITY=UVM_NONE | UVM_LOW | UVM_MEDIUM | UVM_HIGH | UVM_FULL]"
    echo "                [+UVM_SEVERITY=INFO | WARNING | ERROR | FATAL]"
    echo "                [-SVSEED  random | <integer-value>]"
    echo ""
    echo "        demo.sh -h[elp]"
    echo ""
}

# =============================================================================
# Get args
# =============================================================================
gui="-access rc -gui +tcl+$ENV_HOME/minimips_UVM/sim_command.tcl"
other_args="";

while [ $# -gt 0 ]; do
   case $1 in
      -h|-help)
                        usage
                        exit 1
                        ;;
      -batch)
                        gui=""
                        ;;
      *)
                        other_args="$other_args $1"
                        ;;
    esac
    shift
done

# =============================================================================
# Execute
# =============================================================================

irun $other_args $gui -uvmhome `ncroot`/tools/uvm-1.1 \
-incdir $ENV_HOME/sv -incdir $ENV_HOME/minimips_UVM -coverage b:u \
-covoverwrite -nowarn PMBDVX +UVM_TESTNAME=test_read_modify_write +UVM_VERBOSITY=UVM_HIGH \
$ENV_HOME/minimips_UVM/minimips.v \
$ENV_HOME/sv/UFRGS_miniMIPS_if.sv \
$ENV_HOME/sv/UFRGS_miniMIPS_pkg.sv $ENV_HOME/minimips_UVM/minimips_UVM_top.sv
