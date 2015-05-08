function n = countlines(file)
fid=fopen(file);
n = 0;
tline = fgetl(fid);
while ischar(tline)
  tline = fgetl(fid);
  n = n+1;
end

fclose(fid);