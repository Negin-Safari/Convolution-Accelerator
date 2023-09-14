rgb = imread('yelsev.png');

gray = rgb2gray(rgb);
inp = uint8(gray);

mine = fopen ('inputdx.txt', 'wt');
for i = 1:28
    for j = 1:28    
     p = dec2bin(inp(i,j),8);
     c = bin2dec(p);
     fprintf(mine,'%d,\n', c);
    end
end

fclose(mine);


subplot(1,2,1), imshow(inp);
result = zeros(size(inp));
m = 3;
wgray = zeros(size(inp) + 2*floor(m/2));
wgray((floor(m/2) + 1):(28+floor(m/2)),(floor(m/2) + 1):(28+floor(m/2))) = inp;
k = ones(m);
k = k/(m*m);

y = 0;
ik = 0; jk=0;
for row = (floor(m/2) + 1):(28+floor(m/2)) %2
    for col = (floor(m/2) + 1):(28+floor(m/2)) %3
        y = 0;
        ik = 0; 
        jk=0;
        for i = (row - floor(m/2)) : (row + floor(m/2)) %1 - 3
            ik= ik + 1;
         for j = (col - floor(m/2)) : (col + floor(m/2)) %2 - 4
            jk= jk + 1;
            y = y + k(ik,jk) * wgray(i,j);
         end
          jk = 0;
        end
        result(row-floor(m/2),col-floor(m/2)) = y;  
           
    end
end
tt = uint8(floor(result));
marj = floor(result);
fidp = fopen ('output.txt', 'wt');
for i = 1:28
    for j = 1:28    
     p = dec2bin(tt(i,j),8);
     fprintf(fidp,'%s\n', p);
    end
end

fclose(fidp);


% subplot(1,2,2),imshow(uint8(result));

% fileID = fopen('b.bin');
% A = fread(fileID);
% 
printA = zeros(28);
f = fopen('lowacc_out.txt');
for i = 1:28
    for j = 1:28  
      onep=textscan(f, '%s\n');
     printA(i,j) = bin2dec(onep{1});
    end
end

fclose(f);

subplot(1,2,2),imshow(uint8(printA));

err = 0;
for i = 1:28
    for j = 1:28    
     err=((marj(i,j)-printA(i,j))^2  + err);
    end
end


err = (err/(28*28));

reserr = sqrt(err);



errl = 0;
for i = 1:28
    for j = 1:28    
     errl= marj(i,j) + errl;
    end
end

errl = errl/(28*28);


percErr = err/errl;
