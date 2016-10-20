Program move;
Const inf							=		'move.in';
	  ouf							=		'move.out';
      maxn                          =       202;
	  zl							:		array [1..4,1..2] of longint
									=		((0,1),(0,-1),(1,0),(-1,0));
Type PIT							=		record a,b,d,l,r:longint; c:boolean; end;
Var best                    		:       array [0..maxn] of record value,father:longint; end;
Var ok,b,vd							:		array [0..maxn,0..maxn] of boolean;
    save							:		array [0..maxn] of record y,x:longint; end;
    dist							:		array [0..maxn>>1,0..maxn>>1,0..maxn>>1] of longint;
	queue							:		array [0..maxn*maxn] of longint;
    c,f,w,g							:		array [0..maxn,0..maxn] of longint;
	deg,d,p							:		array [0..maxn] of longint;
	oo,mk							:		array [0..maxn] of boolean;
	q								:		array [0..maxn*maxn] of record y,x,s:longint end;
	i,j,m,n,x,y,s,t,ans,sum,v,st,z,id:		longint;

Procedure Add(a,b,x,y:longint);
Begin
	inc(deg[a]); g[a,deg[a]]:=b; c[a,b]:=x; w[a,b]:=y;
	inc(deg[b]); g[b,deg[b]]:=a; c[b,a]:=0; w[b,a]:=-y;
End;

Procedure Del(a,b:longint);
Begin
	dec(deg[a]); c[a,b]:=0; w[a,b]:=0;
	dec(deg[b]); c[b,a]:=0; w[b,a]:=0;
End;

Function RFS:boolean;
Var i,j,k,front,rear:longint;
Begin
	fillchar(oo,sizeof(oo),true);
	fillchar(mk,sizeof(mk),false);
	front:=1; rear:=1; oo[s]:=false; d[s]:=0; queue[1]:=s;
	while front<=rear do
	begin
		i:=queue[front];
		mk[i]:=false;
		for k:= 1 to deg[i] do
		begin
			j:=g[i,k];
			if (f[i,j]<c[i,j]) and (oo[j] or (d[j]>d[i]+w[i,j]) ) then
			begin
				oo[j]:=false;
				d[j]:=d[i]+w[i,j];
				p[j]:=i;
				if not mk[j] then
				begin
					inc(rear);
					queue[rear]:=j;
					mk[j]:=true;
				end;
			end;
		end;
                inc(front)
	end;
	if oo[t] then exit(false) else exit(true);
End;

Procedure MRF;
Var i,j:longint;
Begin
	i:=t;
	while i<>s do
	begin
		j:=p[i];
		inc(f[j,i]);
		f[i,j]:=-f[j,i];
		i:=j;
	end;
	inc(sum,d[t]);
End;

Procedure BFS(y0,x0:longint);
var f,r,v,i,j:longint; q:array [0..10000] of record y,x,s:longint; end;
Begin
	f:=1; r:=1; with q[f] do begin y:=y0; x:=x0; s:=0; end;
    fillchar(vd,sizeof(vd),0); vd[y0,x0]:=true;
    dist[id,y0,x0]:=0;
    while f<=r do
	begin
		for v:= 1 to 4 do
		begin
			i:=q[f].y+zl[v,1];
			j:=q[f].x+zl[v,2];
			if ok[i,j] and not vd[i,j] and not b[i,j] then
			begin
				inc(r);
				with q[r] do
				begin
					y:=i;
					x:=j;
					s:=q[f].s+1;
				end;
				vd[i,j]:=true;
                dist[id,i,j]:=q[r].s;
			end;
		end;
		inc(f);
	end;
End;

Procedure Updata;
Var i,j:longint;
Begin
	for i:= 1 to n do for j:= 1 to n do with q[j] do if not b[y,x] then add(i+1,j+1+n,1,dist[i,y,x]);
	for i:= 1 to n do add(i+1+n,t,1,0);
    fillchar(f,sizeof(f),0);
	sum:=0;
	while rfs do mrf;
	for i:= 1 to n do for j:= 1 to n do with q[j] do if not b[y,x] then del(i+1,j+1+n);
	for i:= 1 to n do del(i+1+n,t);
	for i:= 1 to n do if f[s,i+1]<>1 then exit;
	if sum<ans then ans:=sum;
End;

Begin
	assign(input,inf);								reset(input);
	assign(output,ouf);								rewrite(output);

	readln(n,m);
	s:=1; t:=2+n<<1; fillchar(dist,sizeof(dist),1);
	for i:= 1 to n do for j:= 1 to n do ok[i,j]:=true;
	for i:= 1 to n do with save[i] do read(y,x);
	for j:= 1 to m do begin read(y,x); b[y,x]:=true; end;
	for i:= 1 to n do with save[i] do begin id:=i; BFS(y,x); Add(s,i+1,1,0); end;
	ans:=maxlongint;
	for i:= 1 to n do begin
		for j:= 1 to n do with q[j] do begin y:=i; x:=j; end;
			updata; end;
	for j:= 1 to n do begin
		for i:= 1 to n do
                with q[i] do begin y:=i; x:=j; end;
			updata; end;
	for i:= 1 to n do with q[i] do begin y:=i; x:=i; end;  		updata;
	for i:= 1 to n do with q[i] do begin y:=i; x:=n-i+1; end;	updata;
	if ans=maxlongint then writeln(-1) else writeln(ans);

	close(input);									close(output);
END.
