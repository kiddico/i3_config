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
my $color = "";

# read the first line of the "acpi" command output
open (ACPI, "acpi -b | grep 'Battery $bat_number' |") or die;
$acpi = <ACPI>;
close(ACPI);

# fail on unexpected output
if ($acpi !~ /: (\w+), (\d+)%/) {
	die "$acpi\n";
}

$status = $1;
$percent = $2;

if ($percent < 5) {
	my $temp = "!  ";
	$temp .= "$percent";
	print "$temp";
	exit(33);
}

if ($status eq 'Discharging') {

	if ($percent < 30) {
		$battery_icon ="  ";
		$color="#9FD84F";
	}
	elsif ($percent < 60) {
		$battery_icon ="  ";
		$color="#E6E854";

	}
	elsif ($percent < 80) {
		$battery_icon ="  ";
		$color="#E6E854";

	}
	elsif ($percent < 99) {
		$battery_icon ="   ";
		$color="#E89254";

	}

} #End of outter if
elsif ($status eq 'Charging') {
	$full_text .= '  ';
}

## Concatenate all the bits together
$full_text .= "$battery_icon";
$full_text .= "$percent";

print "$full_text\n";
print "$short_text\n";
print $color;



exit(0);

