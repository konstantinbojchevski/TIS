function izhod = naloga4(vhod,Fs)

N = length(vhod);
X = fft(vhod);
deltaF = Fs / N;
Fx = (0:N-1) * deltaF;
P = (abs(X)).^2 / N;

rezultat = "";
found = 0;
prv = 1;
vtor = 1;
tret = 1;

keySet = {'C_1', 'CIS_1', 'D_1', 'DIS_1', 'E_1', 'F_1', 'FIS_1', 'G_1', 'GIS_1', 'A_1', 'B_1', 'H_1', 'C_2', 'CIS_2', 'D_2', 'DIS_2', 'E_2', 'F_2', 'FIS_2', 'G_2', 'GIS_2', 'A_2', 'B_2', 'H_2'};
valueSet = [261.63 277.8 293.66 311.13 329.63 349.23 369.99 392 415.30 440 466.16 493.88 523.25 554.37 587.33 622.25 659.25 698.46 739.99 783.99 830.61 880 932.33 987.77];
M = containers.Map(keySet,valueSet);

for i = 1:length(Fx) / 2
    if(Fx(i) >= 250 && Fx(i) <= 1000)
        
        if(P(i) > P(prv))
            tret = vtor;
            vtor = prv;
            prv = i;
            continue;
        end
        
        if(P(i) > P(vtor))
            tret = vtor;
            vtor = i;
            continue;
        end
        
        if(P(i) > P(tret))
            tret = i;
        end
    end
end

p=Fx(prv);
v=Fx(vtor);
t=Fx(tret);

if(v>p)
    temp=v;
    v=p;
    p=temp;
end

if(t>p)
    temp=t;
    t=p;
    p=temp;
end

if(t>v)
    temp=t;
    t=v;
    v=temp;
end

keySet_2 = {'Cdur', 'Cmol', 'Ddur', 'Dmol', 'Edur', 'Emol', 'Fdur', 'Fmol', 'Gdur', 'Gmol', 'Adur', 'Amol', 'Hdur', 'Hmol'}; 
valueSet_2 = [{'C_1', 'E_1', 'G_1'}; {'C_1', 'DIS_1', 'G_1'}; {'D_1', 'FIS_1', 'A_1'}; {'D_1', 'F_1', 'A_1'}; {'E_1', 'GIS_1', 'H_1'}; {'E_1', 'G_1', 'H_1'};
    {'F_1', 'A_1', 'C_2'}; {'F_1', 'GIS_1', 'C_2'}; {'G_1', 'H_1', 'D_2'}; {'G_1', 'B_1', 'D_2'}; {'A_1', 'CIS_2', 'E_2'}; {'A_1', 'C_2', 'E_2'}; {'H_1', 'DIS_2', 'FIS_2'}; {'H_1', 'D_1', 'FIS_2'}];        

for i = 1:length(keySet_2)
    
        for k = 1:3              
            ton = valueSet_2(i, k);
            ton = char(ton);
            if(t >= M(ton)-10 && M(ton)+10 >= t && found == 0)
                k = k + 1;
                ton = valueSet_2(i, k);
                ton = char(ton);
                if(v >= M(ton)-10 && M(ton)+10 >= v)
                    k = k + 1;
                    ton = valueSet_2(i, k);
                    ton = char(ton);
                    if(p >= M(ton)-10 && M(ton)+10 >= p)
                        found = 1;
                        rezultat = keySet_2(i);
                    end
                end
            else
                break;
            end
        end
        i = i + 1;
end

    izhod = char(rezultat);
end