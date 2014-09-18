#!/usr/bin/python

import sys
import re
import argparse

def command_line():
    args = argparse.ArgumentParser()
    args.add_argument('-f', '--file', type=argparse.FileType('r'),
                      default=open('mmcc.vcd', 'r'), dest='vcd')
    args.add_argument('-s','--signal', 
      metavar='[PARENT|]MODULE:SIGNAL=VALUE[|VALUE|...]',
                      required=True)
    args.add_argument('-c', '--condition', metavar='SIGNAL=VALUE',
                      action='append')
    args.add_argument('-d', '--debug', action='store_true')
    
    return args.parse_args()

class Signal:
    def __init__(self, name, arg, module, value=''):
        self.name = name
        self.value = value
        self.arg = arg
        self.module = module
        self.index = 0
        self.valid = False

    def complete(self, bits, var):
        self.valid = True
        self.var = var
        self.bits = bits
        self._convert()
        exp = ''
        for c in var:
           exp = exp + '[' + c + ']' 
        if (bits == '1'):
            self.exp = re.compile('^([UuXxZzWwLlHh01-])' + exp)
        else:
            self.exp = re.compile('^b([UuXxZzWwLlHh01-]{' + bits + '}) ' + exp)
    
    def next(self):
        if(len(self.valid) > (self.index + 1)):
            self.index = self.index + 1
            return False
        return True
            
    def valid_value(self):
        return self.valid[self.index]

    def is_last(self):
        if(len(self.valid) > (self.index + 1)):
            return False
        return True

    def hex_value(self):
        return hex(int(self.value, 2))
        
    def hex_valid_value(self):
        return hex(int(self.valid[self.index],2))

    def dump(self):
        print "name: " + self.name
        print "var: " + self.var
        print "pattern: " + self.exp.pattern
        print "num bits: " + self.bits
        print "arg:"; print  self.arg
        print "module:"; print self.module
        print "valid:"; print self.valid
        print "exp: "; print self.exp.pattern

    def _convert(self):
        _dec = re.compile('^[Dd]([0-9]+)$')
        _bin = re.compile('^[01]+$')
        _hex = re.compile('^0[xX](([A-F\d]|[a-f\d])+)$')
        if self.bits == 1:
           for v in self.arg:
               if len(v) > 1 or not(self._is_base(v, _bin)):
                   self._error('Invalid bit value' ,self.name + ' -> ' + v)
           self.valid = self.arg
        else:
            self.valid = []
            b = int(self.bits)

            for v in self.arg:
                num = None
                if self._is_base(v, _bin):
                    #print 'BIN'
                    num = v.zfill(b)
                elif self._is_base(v, _hex):
                    #print 'HEX'
                    n = _hex.search(v)
                    num = bin(int(n.group(1), 16))[2:].zfill(b)
                elif self._is_base(v, _dec):
                    #print 'DEC'
                    n = _dec.search(v)
                    num = bin(int(n.group(1), 10))[2:].zfill(b)
                else:
                    self.error('Invalid value.' ,self.name + ' -> ' + v)    

                if b != len(num):
                    self.error('Invalid range value.' ,
                               self.name + '=' + v + \
                                   ' ['+ self.bits + ' bit(s)]')
                
                self.valid.append(num)
             

    def _is_base(self, value, exp):
        x = exp.search(value)
        if x != None:
            return True
        return False

    def error(self, msgErr, msg):
        print >> sys.stderr, 'Error. ' + msgErr
        print >> sys.stderr, msg
        sys.exit(-2)

def find_module(arg, moduleInitRegex, moduleEndRegex, fileVcd):
    moduleTree = arg.split('|')
    last = len(moduleTree) - 1
    index = 0
    found = False    
    
    fileVcd.seek(0)
    
    m = None;
    for line in fileVcd:
        m = moduleInitRegex.search(line)
        if m != None and m.group(1) == moduleTree[index]:
            if index == last:
                found = True
                break
            index = index + 1
            continue
        e = moduleEndRegex.search(line)
        if e != None:
            break
    return found 

def make_vec(arg):
    signalArg = []
    parse = arg.signal.split('=')

    if len(parse) != 2:
        print >> sys.stderr, "Error syntax at signal '=' in -s option"
        sys.exit(-5)
    module = parse[0].split('@')

    if len(module) == 1:
        print >> sys.stderr, "Error syntax at signal '@' in -s option"
        sys.exit(-5)

    arg0 = Signal(module[1], parse[1].split('|'), module[0])
    signalArg.append(arg0)
    if arg.condition != None:
        for s in arg.condition:            
            parse = s.split('=')
            if len(parse) != 2:
                print >> sys.stderr, "Syntax error at signal '='"
                sys.exit(-5)
            
            module = parse[0].split('@')
                
            if len(module) == 1:
                print >> sys.stderr, "Syntax error at signal '@'"
                sys.exit(-5)

            argN = Signal(module[1], parse[1].split('|'), module[0])
            signalArg.append(argN)

    return signalArg

#def find_signal(

def is_valid(signalArg):
    for s in signalArg[1:]:
        if s.value != s.valid_value():
            return False
    return True

def next_signals(signalArg):
    for s in signalArg[1:]:
        s.next()
        
if __name__ == '__main__':
    
    arg = command_line()
    endVars = re.compile('\$enddefinitions') 
    module = re.compile('\$scope module (\S+) \$end')
    signal = re.compile('\$var reg (\d+) (\S+) ((\w+)([[]\d+:\d+[]])?) \$end')
    endModule = re.compile('\$upscope \$end')
    timeChanged = re.compile('^#(\d+)')
    
    signalArg = make_vec(arg)

    for sig in signalArg:
        found = find_module(sig.module, module, endVars, arg.vcd)
        
        if not found:
            print >> sys.stderr, 'Module '
            print sig.module
            print ' not found.'
            sys.exit(-4)
         
        indent = 0
        for line in arg.vcd:
            
            s = signal.search(line)
            if s != None and indent == 0:
                if sig.name == s.group(3) or sig.name == s.group(4):
                    sig.complete(s.group(1), s.group(2))
                    #sig.dump()
                    break
                continue
            m = module.search(line)
            if m != None:
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

        if not sig.valid:
            print >> sys.stderr, 'Signal ' + sig.name + ' not found.'
            sys.exit(-5)
    
    for line in arg.vcd:        
        t = timeChanged.search(line)
        if t != None:
            #print "time - " + t.group(1)
            break
        
    for line in arg.vcd:        
        t = timeChanged.search(line)
        if t != None:
            #print "time - " + t.group(1)
            if is_valid(signalArg):
                if signalArg[0].valid_value() == signalArg[0].value:

                    if arg.debug:
                        print "[" + t.group(1) + "] " + \
                          signalArg[0].name  + " -> " + signalArg[0].hex_value()

                    last = signalArg[0].next()
                    if last:
                        print >> sys.stderr, 'Ok'
                        sys.exit(1)
                    next_signals(signalArg)
                else:
                    d = signalArg[0].name + '!='
                    d = d + signalArg[0].hex_valid_value()
                    d = d + ' value=' + signalArg[0].hex_value()
                    signalArg[0].error('Value not match.', d) 
                    
            continue
        for sig in signalArg:
            s = sig.exp.search(line)
            if s != None:
                #print s.group(1)
                sig.value = s.group(1)
                break
        
