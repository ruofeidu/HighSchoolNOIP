Program profit;
Uses Math;
Const inf					=			'profit.in';
	  ouf					=			'profit.out';
	  maxn					=			60000;
	  maxm					=			160000;
Var e						:			array [-maxm..maxm] of record v,next,x,y:longint end;
	f						:			array [0..maxn] of record vd,current,link:longint end;
	p,a,b,c					:			array [0..maxm] of longint;
	n,m,s,t,ans,sum,i,j,r,delta		:			longint;
	
Procedure Add(a,b,c:longint);
Begin
	inc(r);
	with e[r]  do with f[a] do begin v:=b; x:=c; next:=link; link:=r; end;
	with e[-r] do with f[b] do begin v:=a; x:=0; next:=link; link:=-r end;
End;

Function Rfs(cv,zl:longint):boolean;
Var i:longint;
Begin
	if cv=t then begin delta:=zl; exit(true); end;
	with f[cv] do begin vd:=ans; i:=current;
	repeat
		with e[i] do begin
		if (y<x) and (f[v].vd<>ans) and (Rfs(v,Min(zl,x-y))) then
		begin
			inc(y,delta);
			e[-i].y:=-y;
			current:=i;
			exit(true);
		end;
		i:=next; end;
		if i=0 then i:=link;
	until i=current; end;
	exit(false);
End;

Begin
	assign(input,inf);					reset(input);
	assign(output,ouf);					rewrite(output);

	readln(n,m);
	for i:= 1 to n do read(p[i]);
	for i:= 1 to m do read(a[i],b[i],c[i]);
	
	s:=n+m+1;	t:=s+1;
	
	for i:= 1 to m do
	begin
		add(a[i],i+n,maxlongint);
		add(b[i],i+n,maxlongint);
		add(i+n,t,c[i]);
		inc(sum,c[i]);
	end;
	for i:=1 to n do add(s,i,p[i]);

	for i:= 1 to t do with f[i] do begin current:=link; vd:=-1 end;
	while RFS(s,maxlongint) do inc(ans,delta);

	writeln(sum-ans);
	close(input);							close(output);
END.
