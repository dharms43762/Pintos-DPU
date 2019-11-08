# -*- perl -*-
use tests::tests;
use tests::threads::alarm;

# check for the expected idle ticks
check_alarm_idle( 250 );

check_alarm (1);
