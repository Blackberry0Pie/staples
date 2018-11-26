######################################################
# Shawn Shadrix
# 4/18/2016 - initial
# 4/20/2016 - v2 updated logic
# 4/22/2016 - v3 removed Onyx
#
# Parses an input file into a tab-separated.txt file
# to be imported into a spreadsheet program.
######################################################
#open sequence
my $exists = 0;
my $kit;
open my $fh, '<', $ARGV[0] or die "Unable to open input file: $ARGV[0]\n";
chomp(my @lines = <$fh>);
close $fh;

if(-e 'staples_out.txt'){
  $exists = 1;
}
open (OUTFILE,'>>staples_out.txt') or die "Unable to access out.txt";
select OUTFILE;
unless($exists){
  print "Employee Start Date	First Name	Last Name	Company	Job Title	Type of Kit	Address Line 1	Address Line 2	Address Line 3	City	State 	Zip	Email	Phone	Staff ID	Cost Center	Company Code	Business Unit 	User ID\n";
}

#parse sequence
print $lines[5] =~ /(?<=Hire Date:	)([^\t]+)/;
print "\t";
print $lines[4] =~ /(?<=First Name: 	)([^\t]+)/; 
print "\t";
print $lines[5] =~ /(?<=Last Name:	)([^\t]+)/; 
print "\t";
print '[redacted]';
print "\t";
($kit) = $lines[6] =~ /(?<=Job Title:	)([^\t]+)/;
if($kit =~ /\bmgr\b/i){
  $kit = 'DM';
} elsif($kit =~ /\bmanager\b/i){
  $kit = 'DM';
} elsif($kit =~ /\brep\b/i){
  $kit = 'BSR';
}
print '[redacted] ' . $kit;
print "\t";
print  $kit . ' Kit';
print "\t";
print $lines[16] =~ /(?<=Address 1:	)([^\t]+)/; 
print "\t";
print $lines[17] =~ /(?<=Address 2:	)([^\t]+)/; 
print "\t";
print $lines[18] =~ /(?<=Address 3:	)([^\t]+)/; 
print "\t";
print $lines[16] =~ /(?<=City:	)([^\t]+)/; 
print "\t";
print $lines[17] =~ /(?<=State:	)([^\t]+)/; 
print "\t";
print $lines[18] =~ /(?<=Zip Code:	)([^\t]+)/; 
print "\t";
#print $lines[29] =~ /([^\t ]+@[^\t ]+)/;
print $lines[3] =~ /(?<=Login Name:	)([^\t]+)/; 
print "\@[redacted].com\t";
my($temp) = $lines[26] =~ /(?<=Cell:	)([^\t]+)/;
unless (defined $temp) {
  ($temp) = $lines[25] =~ /(?<=Phone:	)([^\t]+)/;
}
$temp =~ s/\(//;
$temp =~ s/\)//;
$temp =~ s/ /-/;
print $temp;
print "\t";
print $lines[3] =~ /(?<=Staff ID:	)([^\t]+)/;
print "\t";
print $lines[9] =~ /(?<=Cost Center No:	)([^\t]+)/;
print "\t";
print '1002';
print "\t";
print $lines[10] =~ /(?<=Business Unit:	)([^\t]+)/;
print "\t";
#print $lines[29] =~ /([^\t ]+@[^\t ]+)/;
print $lines[3] =~ /(?<=Login Name:	)([^\t]+)/; 
print "\@[redacted].com\n";

#close sequence
close (OUTFILE);
exit;
