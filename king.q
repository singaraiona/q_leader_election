// timeout
T:1;
// get current timestamp
ts:{"v"$.z.t};
// debug function
print:{0N!x;};
// all nodes in ring
nodes:(`::5001`::5002`::5003);
// get local address:port
lap:{(":","."sv string"i"$0x0 vs .z.a),":",string system "p"};
// the same except address
addrp:{`$"::",string system "p"};
// initials
reply:`;seq:0;
// king api
id:$[(count nodes)>n:1+nodes?addrp[];n;-1];
// just info about starting instance.
print string id;
// get all parents should be alive?
parents:$[-1<>id;id _ nodes;()];
// are we the king?
king:$[-1=id;`we;`];
weking:{king=`we};
// callback function: called from other side of connection via async request `req
clb:{reply::x;print lap[], " ",(string x)," seq:",(string y),z};
// parse requested function from api
res:({$[weking[];`IMTHEKING;`FINETHANKS]};{};{};{`PONG});
// async request
req:{print lap[], " REQ: ", string x;(neg .z.w)(z;(((`$"ALIVE?";`$"FINETHANKS";`$"IMTHEKING";`$"PING")!(res))x)[];y;lap[])};
// condition: received reply or timeout is reached
cx:{"b"$neg (reply<>`) or ts[]>x+T*4};
// wait until condition cx reaches
wc:{print lap[], " WC ",string ts[];{x}/[{cx[x]};ts[]]};
// api request
ask:{reply::`;(neg hopen hsym x)(`req;y;seq;`clb)};
// alive?
chk:{ask[x;`$"ALIVE?"]};
// ping
ping:{print lap[]," PING ",string ts[];ask[x;`PING]};
// initiate election
elect:{{chk x; wc[]}'[parents];};
elect[];
// set proper king handle
king:$[weking[];`we;last parents];
// debug
print lap[], " king: ",$[weking[];"we are the king";string king]
// states
ki:{};
nk:{ping king;wc[];print lap[]," REPLY: ",(string reply),string ts[];if[reply<>`PONG;elect[]]};
// monitor participants 
tick:{$[weking[];ki[];nk[]]};
// setup timer
.z.ts: {tick[]};
system "t ", string 4000*T;
