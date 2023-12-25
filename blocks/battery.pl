#!/usr/bin/perl

use strict;
use warnings;
use utf8;
my $acpi;
my $status;
my $percent;
my $full_text = "";
my $short_text = "";
my $bat_number = 0;
my $battery_icon = "";
my $icon ="";
my $color = "";

# read the first line of the "acpi" command output.
# ohhhh okay. I'm gonna assume that's what fills in the percent and status below.
# also 'or die' makes me smile.
open (ACPI, "acpi -b | grep 'Battery $bat_number' |") or die;
$acpi = <ACPI>;
close(ACPI);

# If the string "Unknown" is in $acpi then there probably isn't actually a battery here...
# Also, sometimes a battery that doesn't actualluy exist will be detected as 'Discharging, 0%'
# I don't know perl so this is just going to be two ifs for now...
if (index($acpi, "Unknown") != -1) {
	die;
}
if(index($acpi, "Discharging, 0") != -1) {
	die;
}

if(index($acpi, "Not Charging") != -1) {
	# fail on unexpected output
	if ($acpi !~ /: (\w+), (\d+)%/) {
		die "$acpi\n";
	}
	
	$status = $1;
	$percent = $2; # how does that work?...
}
else{
	if ($acpi !~ /: (\w+) (\w+), (\d+)%/) {
		die "$acpi\n";
	}

	$status = "$1 $2";
	$percent = $3; # how does that work?...
}

if ($percent < 5) {
	my $temp = "!  ";
	$temp .= "$percent";
	print "$temp";
	exit(33);
}

# Now, I'm not gonna name any names,
# but someone might want to turn this into a switch statement.
# assuming perl supports that sort of thing...
# I'm gonna guess yes.

# Choose Color, and Battery Icon
if ($percent < 30) {
	$battery_icon =";
	$color="#E89254";

}elsif ($percent < 60) {
	$battery_icon ="";
	$color="#E6E854";

}elsif ($percent < 80) {
	$battery_icon ="";
	$color="#E6E854";

}elsif ($percent < 101) {
	$battery_icon ="";
	$color="#9FD84F";
}# fi

# Use the battery icon chosen above or wall plug icon
if ($status eq 'Discharging') {
	$icon=$battery_icon;
	# For some reason if my framework laptop is at 100% charge it will report
	# that it's discharging despite being plugged in.
	if ($percent eq 100){
		$icon= "";
		$percent="";
	}
}
elsif ($status eq 'Charging') {
	$icon= "";
}
elsif (index($acpi, "Not charging") != -1) {
	$percent= "";
	$icon= "";
}
else {
    $icon=$battery_icon;
}



## Concatenate all the bits together
### note: do NOT include EOL!!
if ($percent ne ""){
	$percent= " $percent";
}
$full_text .= "$icon$percent";
#$full_text .= "$percent";
$short_text .= "$percent";

print "$full_text\n";  #   42 /   42
print "$short_text\n"; # 42
print "$color\n";      # red -> green
exit(0);
