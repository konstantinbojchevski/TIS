function H = naloga1(besedilo, p)

B = upper(besedilo(isletter(besedilo)));
B = double(B);

% za p = 0 :
UB1 = unique(B);
P1 = histcounts(categorical(B), categorical(UB1));
P1 = P1/length(B);
H1 = -P1*log2(P1');
if(p == 0)
    H = H1;
    return
end

% za p = 1 :
DB = [B(1:end-1), B(2:end)];

[UB2, iA, iC] = unique(DB, 'rows');
P2 = histcounts(categorical(iC), categorical([1:length(iA)]));
P2 = P2/length(iC);
H2 = -P2*log2(P2');
if(p == 1)
    H = H2 - H1;
    return
end

% za p = 2 :
TB = [B(1:end-2), B(2:end-1), B(3:end)];

[UB3, iA, iC] = unique(TB, 'rows');
P3 = histcounts(categorical(iC), categorical([1:length(iA)])); 
P3 = P3/length(iC);
H3 = -P3*log2(P3');
if(p == 2)
    H = H3 - H2;
    return
end

% za p = 3 :
QB = [B(1:end-3), B(2:end-2), B(3:end-1), B(4:end)];

[UB4, iA, iC] = unique(QB, 'rows');
P4 = histcounts(categorical(iC), categorical([1:length(iA)])); 
P4 = P4/length(iC);
H4 = -P4*log2(P4');
H = H4 - H3;

end