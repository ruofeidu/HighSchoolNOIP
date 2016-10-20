Program KMP;
Const inf			=		'kmp.in';
	  ouf			=		'kmp.out';
	  maxn			=		20000000;
Var a,b				:		array [0..maxn] of char;
	p				:		array [0..maxn] of longint;
	i,j,n,m,ans		:		longint;

procedure ComputePrefix;
var
	i, k: longint;
begin
	P[1] := 0;
	k := 0;
	for i := 2 to m do
	begin
		while (k > 0) and (b[k + 1] <> b[i]) do
			k := P[k];
		if b[k + 1] = b[i] then
			Inc(k);
		P[i] := k;
	end;
end;

procedure KMP;
var
	i, k: longint;
begin
	k := 0;
	for i := 1 to n do
	begin
		while (k > 0) and (b[k + 1] <> a[i]) do
			k := P[k];
		if b[k + 1] = a[i] then
			Inc(k);
		if k = M then
		begin
			Writeln(i - k + 1);
			//exit;
			k := P[k]; //Seek for next match
		end;
	end;
end;

{Procedure NEXT;
Var i,j:longint;
Begin
	p[1]:=0;
	j:=0;
	for i:= 2 to m do;
	begin
		while (j>0) and (b[j+1]<>b[i]) do j:=p[j];
		if b[j+1]=b[i] then inc(j);
		p[i]:=j;
	end;
End;

Function KMP:longint;
Var i,j:longint;
begin
	NEXT;
        j:=0;
	for i:= 1 to n do
	begin
		while (j>0) and (b[j+1]<>a[i]) do j:=p[j];
		if b[j+1]=a[i] then inc(j);
		if j=m then
        begin
            exit(i-j+1);
		    j:=p[j];
        end;
	end;
	exit(0);
End;}

Begin
	assign(input,inf);		reset(input);
	assign(output,ouf);		rewrite(output);

	readln(n);
	for i:= 1 to n do read(a[i]); readln;
	readln(m);
	for i:= 1 to m do read(b[i]); readln;
	ComputePrefix;
	KMP;
	//writeln(KMP);
	close(input);			close(output);
END.
