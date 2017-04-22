#!/usr/bin/python
import csv
import argparse
import sys

parser = argparse.ArgumentParser(description='Generate a File for Yealink EXP40 LCD Expansion Module (Auto Provisioning)')
parser.add_argument('-csv', help='Path to CSV file (with Tel , Name)')
args = parser.parse_args()

if args.csv:
	complett = csv.reader(open(args.csv, "rb"),delimiter=';')
	complett_list = []
	complett_list.extend(complett)
	tel = []
	names = []
	for data in complett_list:
	    tel.append(data[0])
	for data in complett_list:
	    names.append(data[1])
	count = 0
	ccount = 1
	expansion = 40
	while count <= len(tel)-1:
		if count == expansion:
			ccount = 1
		if count < expansion:
			module = "1"
		else:
			module = "2"
		print "#Account Number: "+ tel[count]
		print "expansion_module." + module + ".key."+ str(ccount) +".type = 16"
		print "expansion_module." + module + ".key."+ str(ccount) +".line = 1"
		print "expansion_module." + module + ".key."+ str(ccount) +".value = " + tel[count]
		print "expansion_module." + module + ".key."+ str(ccount) +".label = ["+ tel[count] + "] " + names[count]
		print ""
		count = count + 1
		ccount = ccount + 1
else:
	parser.print_usage()
