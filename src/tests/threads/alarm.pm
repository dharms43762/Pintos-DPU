sub check_alarm {
    my ($iterations) = @_;
    our ($test);

    @output = read_text_file ("$test.output");
    common_checks ("run", @output);

    my (@products);
    for (my ($i) = 0; $i < $iterations; $i++) {
	for (my ($t) = 0; $t < 5; $t++) {
	    push (@products, ($i + 1) * ($t + 1) * 10);
	}
    }
    @products = sort {$a <=> $b} @products;

    local ($_);
    foreach (@output) {
	fail $_ if /out of order/i;

	my ($p) = /product=(\d+)$/;
	next if !defined $p;

	my ($q) = shift (@products);
	fail "Too many wakeups.\n" if !defined $q;
	fail "Out of order wakeups ($p vs. $q).\n" if $p != $q; # FIXME
    }
    fail scalar (@products) . " fewer wakeups than expected.\n"
      if @products != 0;
    pass;
}

# function to test alarm to make sure it didn't just spin-wait
# Douglas Harms
sub check_alarm_idle {
    my ($expected_idle_ticks) = @_;
    our ($test);
    
    @output = read_text_file("$test.output");
    
    my ($tick_stats) = grep (/Thread:/, @output);
    my ($idle_ticks) = $tick_stats =~ /(\d+)/;
    
    if(($idle_ticks>$expected_idle_ticks + 25) || ($idle_ticks<$expected_idle_ticks - 25))  {
      fail "idle ticks was ".$idle_ticks." which is not in the expected range [".($expected_idle_ticks-25)."-".($expected_idle_ticks+25)."]\n"
    }
}

1;
