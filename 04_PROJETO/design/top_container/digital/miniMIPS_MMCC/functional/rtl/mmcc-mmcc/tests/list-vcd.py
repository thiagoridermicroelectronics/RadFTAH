#!/usr/bin/env python

import sys
import re
import argparse

def command_line():
    args = argparse.ArgumentParser(
        description='List module and signal names of a VCD file.')
    args.add_argument('-f', '--file', type=argparse.FileType('r'),
		      default=open('mmcc.vcd', 'r'), dest='vcd')
    args.add_argument('-m','--module', metavar='[PARENT|...|]MODULE')
    
    return args.parse_args()

if __name__ == '__main__':
    
    arg = command_line()
    endVars = re.compile('\$enddefinitions') 
    module = re.compile('\$scope module (\S+) \$end')
    signal = re.compile('\$var reg \d+ \S+ (\S+) \$end')
    endModule = re.compile('\$upscope \$end')
 
    indent = 0
    v = 3
    i = ' ' * v

    if arg.module == None:
        for line in arg.vcd:
            m = module.search(line)
            if m != None:
                i = ' ' * v * indent
                print i + m.group(1)
                indent = indent + 1
                continue
            m = endModule.search(line)
            if m != None:
                indent = indent - 1;
                continue
            e = endVars.search(line)
            if e != None:
                break
        
    else:
        moduleTree = arg.module.split('|')
        last = len(moduleTree) - 1
        index = 0
 
        listSignals = False
        for line in arg.vcd:
            m = module.search(line)
            if m != None and m.group(1) == moduleTree[index]:
                print i * index + '{' + moduleTree[index] + '}'
                if index == last:
                    listSignals = True
                    break
                index = index + 1
                continue
            e = endVars.search(line)
            if e != None:
                break

        if listSignals:
            for line in arg.vcd:
		s = signal.search(line)
		if s != None and indent == 0:
		    print i * (index + 1) + s.group(1)
                    continue
                m = module.search(line)
                if m != None:
                    print i * (index + 1) + '{' + m.group(1) + '}'
                    indent = indent + 1
                    continue
                m = endModule.search(line)
                if m != None:
                    if indent == 0:
                        break
                    else:
                        indent = indent - 1;
                    continue
                e = endVars.search(line)
                if e != None:
                    break
