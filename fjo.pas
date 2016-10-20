Program fjo;
const inf='fjo.in'; ouf='fjo.out'; maxn=2673;
Var best                    :               array [0..maxn] of record value,father:longint; end;
var f,c,a,w,b:array [0..maxn,0..maxn] of longint;
	g,id:array [0..maxn,0..maxn] of integer;
	d,q:array [0..maxn] of longint;
	p:array [0..maxn] of integer;
	oo:array [0..maxn] of boolean;
	n,m,i,j,k,o,ans,s,t,ss,kk:longint;

Procedure Giveedge(u,v:longint);
Begin
    inc(d[u]);
    g[u,d[u]]:=v;
    inc(d[v]);
    g[v,d[v]]:=u;
End;
	
procedure add(u,v,x,y:longint);
begin
	inc(d[u]); g[u,d[u]]:=v; c[u,d[u]]:=x; w[u,d[u]]:=-y;
	inc(d[v]); g[v,d[v]]:=v; c[v,d[v]]:=0; w[v,d[v]]:=y;
end;

function rfs:boolean;
var i,j,k:integer; fail:boolean;
begin
	fillchar(oo,sizeof(oo),1);
	oo[s]:=false; q[s]:=0;
	repeat
		fail:=true;
		for i:= 1 to t do if not oo[i] then
		for k:= 1 to d[i] do
		begin
			j:=g[i,k];
			if (f[i,j]<c[i,j]) and (oo[j] or (q[j]>q[i]+w[i,j])) then
			begin
				oo[j]:=false;
				q[j]:=q[i]+w[i,j];
				p[j]:=i;
				fail:=false;
			end;
		end;
	until fail;
	if not oo[t] then exit(true) else exit(false);
end;

procedure mrf;
var i,j:integer;
begin
	i:=t;
	while i<>s do
	begin
		j:=p[i];
		inc(f[j,i]);
		f[i,j]:=-f[j,i];
		i:=j;
	end;
	inc(ans,q[t]);
end;

begin
	assign(input,inf); reset(input); assign(output,ouf); rewrite(output);
    readln(m,n,kk);

    k:=(n<<1+m-1)*m>>1;
    for i:= 1 to m do
    for j:= 1 to n+i-1 do
    begin
        inc(s);
        read(b[i,j]);
        a[i,j]:=s;
    end;

    for i:= 1 to m do
    for j:= 1 to n+i-1 do
    begin
        c[a[i,j],a[i,j]+k]:=1;
        giveedge(a[i,j],a[i,j]+k);
        w[a[i,j],a[i,j]+k]:=-b[i,j];
        w[a[i,j]+k,a[i,j]]:=b[i,j];
        if a[i+1,j]<>0   then
        begin
            c[a[i,j]+k,a[i+1,j]]:=1;
            giveedge(a[i,j]+k,a[i+1,j]);
        end;
        if a[i+1,j+1]<>0 then
        begin
            c[a[i,j]+k,a[i+1,j+1]]:=1;
            giveedge(a[i,j]+k,a[i+1,j+1]);
        end;
    end;

    s:=s*2+1;
    ss:=s+1;
    t:=ss+1;
    for i:= 1 to n do begin c[ss,i]:=1; giveedge(ss,i); end;
    for i:= 1 to n+m-1 do begin c[a[m,i]+k,t]:=1; giveedge(a[m,i]+k,t); end;
    c[s,ss]:=kk;
    giveedge(s,ss);

    WHILE RFS DO MRF;
    writeln(-ans);
    close(input);                           close(output);
END.
