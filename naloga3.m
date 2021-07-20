function [izhod, crc] = naloga3(vhod, n)
  
  % Izvedemo dekodiranje binarnega niza vhod, ki je bilo
  % zakodirano s Hammingovim kodom dolzine n.
  % in poslano po zasumljenem kanalu.
  % Nad vhodom izracunamo vrednost crc po standardu CRC-8-CCITT.
  %
  % vhod  - binarni vektor y (vrstica tipa double)
  % n     - stevilo bitov v kodni zamenjavi
  % crc   - crc vrednost izracunana po CRC-8-CCITT 
  %         nad vhodnim vektorjem (sestnajstisko)
  % izhod - vektor podatkovnih bitov, dekodiranih iz vhoda
  
  % ------------------ IZHOD ------------------
  
  m = log2(n + 1);
  k = n - m;
  vhod_crc = vhod;
  vhod = (reshape(vhod, [n, (length(vhod)/n)]))';
  
  H1 = [];
  H2 = [];
  for i=1:n
     if mod(n+1, i) == 0
         H1=[H1,i];
     else
         H2=[H2,i];
     end
  end
  H = [H2,H1];
  H = (dec2bin(H) - '0')';
  H = flip(H);
  Q = H';
  
  s = vhod * H';
  s = mod(s, 2);
  
  e = [];
  for i=1:size(s, 1)
      for j=1:length(Q)
          if Q(j,:) == s(i,:)
            e=[e,1];
          else
            e=[e,0];
          end
      end
  end
  e = reshape(e, [n, size(vhod, 1)]);
  e = e';
  
  y_ = xor(vhod, e);
  i = (y_(1:end,1:k));
  izhod = reshape(i, 1, []);
  
  % ------------------ CRC --------------------
  
  p = zeros(1, 8);
  polinom = [1, 1, 0, 0, 0, 0, 0];
  
  for i=1:length(vhod_crc)
     if xor(vhod_crc(i), p(end)) == 0
         p = circshift(p, 1);
         p(1) = 0;
     else
         p = circshift(p, 1);
         p(1) = 1;
         p(2:end) = xor(p(2:end), polinom);
     end
  end
  
  p = flip(p);
  crc = dec2hex(bin2dec(join(string(p))));

end