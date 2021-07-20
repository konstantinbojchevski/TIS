function [izhod, R] = naloga2(vhod, nacin)
if(nacin == 0)
    
    recnik = containers.Map('KeyType', 'char', 'ValueType', 'double');
    for i = 0:255
        recnik(char(i)) = i;
    end
    
    izhod = [];
    i = 256;
    N = "";
    k = 1;
    
    for j = 1:length(vhod)
       z = string(vhod(j));
       
       if(isKey(recnik, strcat(N, z)))
           N = string(strcat(N, z));
       else
           izhod(1, k) = recnik(N);
           k = k + 1;
           if(i < 4096)
               recnik(string(strcat(N, z))) = i;
               i = i + 1;
           end
           N = string(z);
       end
       
    end
    
    izhod(1, k) = recnik(N);
    
    vhod = double(vhod);
    [redici1, koloni1] = size(vhod);
    [redici2, koloni2] = size(izhod);
    R = (koloni2 * 12) / (redici1 * 8);
    
end

if(nacin == 1)
        
    recnik = containers.Map('KeyType', 'double', 'ValueType', 'char');
    for i = 0:255
        recnik(i) = (char(i));
    end
    
    izhod = [];
    i = 256;
    j = 1;
    n = 1;
    
    k = vhod(j);  %preberi indeks k
    N = recnik(k);
    izhod(1, n) = double(N);  %izpishi N 
    n = n + 1;
    K = string(N);
    
    for j = 2:length(vhod)
        k = vhod(j);
        if(isKey(recnik, k))
            N = string(recnik(k));
        else
            N = string(strcat(K, string(K{1}(1:1))));
        end
        
        for index = 1:(length(N{1}))
            O = N{1}(index:index);
            izhod(1, n) = double(O);
            n = n + 1;
            index = 1 + index;
        end
        
        if(i < 4096)
            recnik(i) = string(strcat(K, string(N{1}(1:1))));
            i = i + 1;
        end
        K = string(N);
        
    end
    
    [redici1, koloni1] = size(vhod);
    [redici2, koloni2] = size(izhod);
    R = (redici1 * 12) / (koloni2 * 8);
end