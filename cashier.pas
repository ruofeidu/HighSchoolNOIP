Program cashier;
//**********************************************************
// [cashier.pas] by HL-drf
// Jan. 30th, 2007
// @FJ
// updated on Feb. 12th
// AC @ HL
//**********************************************************
const mn = 300000;
type node = record
	l,r,c : longint;
end;
var t			: array [0..600000] of node;
ch,ct			: char;
n,min,delta,h	: longint;
nowall,i,k,tot	: longint;

function make(l,r:longint):longint;
var p:longint;
begin
	inc(tot); p:=tot;
	if l<>r then
	begin
		t[p].l:=make(l,(l+r) shr 1);
		t[p].r:=make((l+r) shr 1+1,r);
	end;
	make:=p;
end;

procedure insert(now,a,b,c:longint);
begin
	inc(t[now].c);
	if a=b then exit;
	if c<=(a+b) shr 1 then insert(t[now].l,a,(a+b) shr 1,c)
	else insert(t[now].r,(a+b) shr 1+1,b,c);
end;

procedure clear(now,a,b,c:longint);
begin
	if c<0 then exit;
	if a=b then t[now].c:=0;
	if t[now].c=0 then exit;
	if c<=(a+b) shr 1 then clear(t[now].l,a,(a+b) shr 1,c)
	else begin
		clear(t[now].l,a,(a+b) shr 1,(a+b) shr 1);
		clear(t[now].r,(a+b) shr 1+1,b,c);
	end;
	t[now].c:=t[t[now].l].c+t[t[now].r].c;
end;

function rfs(now,a,b,c:longint):longint;
begin
	if a=b then exit(a);
	if c<=t[t[now].l].c then rfs:=rfs(t[now].l,a,(a+b) shr 1,c)
	else rfs:=rfs(t[now].r,(a+b) shr 1+1,b,c-t[t[now].l].c);
end;

begin
	assign(input,'cashier.in'); reset(input);
	assign(output,'cashier.out'); rewrite(output);

	h:=make(0,mn);
	delta:=100000;
	readln(n,min);
	for i:= 1 to n do
	begin
		readln(ch,ct,k);
		case ch of
			'I': if k>=min then
			begin
				insert(h,0,mn,k+delta);
				inc(nowall);
			end;
			'A': dec(delta,k);
			'S': 
			begin
				inc(delta,k);
				clear(h,0,mn,min+delta-1);
			end;
			'F':
			begin
				if k>t[h].c then writeln('-1') else
				writeln(rfs(h,0,300000,t[h].c-k+1)-delta);
			end;
		end;
	end;
	writeln(nowall-t[h].c);
	close(input); close(output);
END.
