Program ditch;
Uses Math;
Const inf='ditch.in'; ouf='ditch.out'; maxn=1000; maxm=4000000;
Var e:array [-maxm..maxm] of record v,next,x,y:longint end;
	f:array [0..maxn] of record vd,current,link:longint end;
	c:array [0..maxn,0..maxn] of longint;
	n,m,s,t,i,j,k,ans,r,delta:longint;
Procedure Add(a,b,c:longint);
Begin
	inc(r);
	with e[r] do  with f[a] do begin v:=b; x:=c; next:=link; link:=r; end;
	with e[-r] do with f[b] do begin v:=a; x:=0; next:=link; link:=-r end;
End;

Function RFS(cv,zl:longint):boolean;
Var i:longint;
Begin
	if cv=t then begin delta:=zl; exit(true); end;
	with f[cv] do begin vd:=ans; i:=current;
	repeat
		with e[i] do begin
		if (y<x) and (f[v].vd<>ans) and RFS(v,Min(zl,x-y)) then
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
end;

Begin
	assign(input,inf); reset(input); assign(output,ouf); rewrite(output);
	readln(m,n);
	for s:= 1 to m do begin readln(i,j,k); inc(c[i,j],k); end;
	for i:= 1 to n do for j:= 1 to n do if c[i,j]<>0 then add(i,j,c[i,j]);
	s:=1; t:=n; for i:= 1 to t do with f[i] do begin current:=link; vd:=-1 end;
	while RFS(s,maxlongint) do inc(ans,delta);
	writeln(ans);
	close(input);	close(output);
END.
