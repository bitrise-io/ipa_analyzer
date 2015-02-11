#!/bin/bash

#
# Prints the given command, then executes it
#  Example: print_and_do_command echo 'hi'
#
function print_and_do_command {
	echo " -> $ $@"
	$@
}

#
# Print the given command, execute it
#	and exit if error happened
function print_and_do_command_exit_on_error {
	print_and_do_command $@
	if [ $? -ne 0 ]; then
		echo " [!] Failed!"
		exit 1
	fi
}

# test
print_and_do_command_exit_on_error rspec
# build
print_and_do_command_exit_on_error gem build ipa_analyzer.gemspec