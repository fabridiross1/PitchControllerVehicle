function l = ToLatex(transfer)
[Num,Den] = tfdata(transfer,'v');
syms s;
sys_syms=poly2sym(Num,s)/poly2sym(Den,s);
l = latex(sys_syms);
 
end

