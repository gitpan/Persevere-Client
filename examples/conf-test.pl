#!/usr/bin/perl
use warnings;
use strict;
use Persevere::Client;
use JSON::XS;

my $json = JSON::XS->new;

my $persvr = Persevere::Client->new(
	host => "localhost",
	port => "7080",
	auth_type => "none",
#	auth_type => "basic",
#	username => "test",
#	password => "pass",
	debug => 1,
	defaultSourceClass => "org.persvr.datasource.InMemorySource",
#	base_uri => "perseverepath"
);

# createObjects requires an array of hashes, so push your objects (hashes) onto an array

my $className = "Conference";
my $initialclass = $persvr->class($className);

if (!($initialclass->exists)){
	my $outcome = $initialclass->create;
	if (!($outcome->{success})){
		warn "Error creating " . $initialclass->{name} . "\n";
	}
}

my @conf_list = qw(asdf dsac woeid asec 123jfi ascoin WMFDe);

# Create Conferences
foreach my $pos (1 .. 20){
	my $userid = "user$pos";
	my $confid = $conf_list[int(rand(5))];
	my $roomnum = "room" . int(rand(10));
	my %hash = (
		id => $userid,
		confId => $confid,
		fullname => "User $pos",
		room => $roomnum
	);
#	print time() . " ID: $userid\tCID: $confid\tRm: $roomnum\n";
	my @post_data;
	push @post_data, \%hash;
	my $postreq = $initialclass->createObjects(\@post_data);
	if (!($postreq->{success})){
					warn "unable to post data";
	}
}
