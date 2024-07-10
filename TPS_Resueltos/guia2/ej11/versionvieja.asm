tomas@tomas-VM:~/shared/arqui/guia2/ej11$ sudo objdump -D -M intel ej11

ej11:     file format elf32-i386


Disassembly of section .text:

08049000 <_start>:
 8049000:	89 e5                	mov    ebp,esp
 8049002:	bb 26 a0 04 08       	mov    ebx,0x804a026
 8049007:	e8 64 00 00 00       	call   8049070 <print>
 804900c:	8b 4d 00             	mov    ecx,DWORD PTR [ebp+0x0]
 804900f:	41                   	inc    ecx
 8049010:	b8 04 00 00 00       	mov    eax,0x4
 8049015:	f7 e1                	mul    ecx
 8049017:	01 c5                	add    ebp,eax
 8049019:	89 e8                	mov    eax,ebp
 804901b:	50                   	push   eax
 804901c:	ba 00 00 00 00       	mov    edx,0x0

08049021 <_start.print_variables_entorno>:
 8049021:	89 e8                	mov    eax,ebp
 8049023:	01 c8                	add    eax,ecx
 8049025:	8b 00                	mov    eax,DWORD PTR [eax]
 8049027:	85 c0                	test   eax,eax
 8049029:	74 2b                	je     8049056 <_start.print_user>
 804902b:	68 74 a0 04 08       	push   0x804a074
 8049030:	52                   	push   edx
 8049031:	e8 8d 00 00 00       	call   80490c3 <numtostr>
 8049036:	83 c4 04             	add    esp,0x4
 8049039:	5b                   	pop    ebx
 804903a:	e8 31 00 00 00       	call   8049070 <print>
 804903f:	89 c3                	mov    ebx,eax
 8049041:	e8 2a 00 00 00       	call   8049070 <print>
 8049046:	bb 00 a0 04 08       	mov    ebx,0x804a000
 804904b:	e8 20 00 00 00       	call   8049070 <print>
 8049050:	83 c1 04             	add    ecx,0x4
 8049053:	42                   	inc    edx
 8049054:	eb cb                	jmp    8049021 <_start.print_variables_entorno>

08049056 <_start.print_user>:
 8049056:	58                   	pop    eax
 8049057:	05 9c 00 00 00       	add    eax,0x9c
 804905c:	8b 18                	mov    ebx,DWORD PTR [eax]
 804905e:	e8 0d 00 00 00       	call   8049070 <print>

08049063 <_start.exit>:
 8049063:	b8 01 00 00 00       	mov    eax,0x1
 8049068:	cd 80                	int    0x80
 804906a:	66 90                	xchg   ax,ax
 804906c:	66 90                	xchg   ax,ax
 804906e:	66 90                	xchg   ax,ax

08049070 <print>:
 8049070:	60                   	pusha  
 8049071:	e8 35 00 00 00       	call   80490ab <strlen>
 8049076:	89 d9                	mov    ecx,ebx
 8049078:	89 c2                	mov    edx,eax
 804907a:	bb 01 00 00 00       	mov    ebx,0x1
 804907f:	b8 04 00 00 00       	mov    eax,0x4
 8049084:	cd 80                	int    0x80

08049086 <print.print_newline>:
 8049086:	b8 0a 00 00 00       	mov    eax,0xa
 804908b:	50                   	push   eax
 804908c:	89 e1                	mov    ecx,esp
 804908e:	bb 01 00 00 00       	mov    ebx,0x1
 8049093:	ba 01 00 00 00       	mov    edx,0x1
 8049098:	b8 04 00 00 00       	mov    eax,0x4
 804909d:	cd 80                	int    0x80
 804909f:	83 c4 04             	add    esp,0x4
 80490a2:	61                   	popa   
 80490a3:	c3                   	ret    

080490a4 <exit>:
 80490a4:	b8 01 00 00 00       	mov    eax,0x1
 80490a9:	cd 80                	int    0x80

080490ab <strlen>:
 80490ab:	51                   	push   ecx
 80490ac:	53                   	push   ebx
 80490ad:	9c                   	pushf  
 80490ae:	b9 00 00 00 00       	mov    ecx,0x0

080490b3 <strlen.loop>:
 80490b3:	8a 03                	mov    al,BYTE PTR [ebx]
 80490b5:	3c 00                	cmp    al,0x0
 80490b7:	74 04                	je     80490bd <strlen.fin>
 80490b9:	41                   	inc    ecx
 80490ba:	43                   	inc    ebx
 80490bb:	eb f6                	jmp    80490b3 <strlen.loop>

080490bd <strlen.fin>:
 80490bd:	89 c8                	mov    eax,ecx
 80490bf:	9d                   	popf   
 80490c0:	5b                   	pop    ebx
 80490c1:	59                   	pop    ecx
 80490c2:	c3                   	ret    

080490c3 <numtostr>:
 80490c3:	55                   	push   ebp
 80490c4:	89 e5                	mov    ebp,esp
 80490c6:	60                   	pusha  
 80490c7:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 80490ca:	50                   	push   eax
 80490cb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 80490ce:	50                   	push   eax
 80490cf:	e8 06 00 00 00       	call   80490da <_numtostr>
 80490d4:	83 c4 08             	add    esp,0x8
 80490d7:	61                   	popa   
 80490d8:	5d                   	pop    ebp
 80490d9:	c3                   	ret    

080490da <_numtostr>:
 80490da:	55                   	push   ebp
 80490db:	89 e5                	mov    ebp,esp
 80490dd:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
 80490e0:	bb 0a 00 00 00       	mov    ebx,0xa
 80490e5:	6a 00                	push   0x0
 80490e7:	ff 75 08             	push   DWORD PTR [ebp+0x8]

080490ea <_numtostr.ciclo>:
 80490ea:	31 d2                	xor    edx,edx
 80490ec:	58                   	pop    eax
 80490ed:	f7 f3                	div    ebx
 80490ef:	83 c2 30             	add    edx,0x30
 80490f2:	52                   	push   edx
 80490f3:	50                   	push   eax
 80490f4:	85 c0                	test   eax,eax
 80490f6:	75 f2                	jne    80490ea <_numtostr.ciclo>
 80490f8:	83 c4 04             	add    esp,0x4

080490fb <_numtostr.cargar_en_memoria>:
 80490fb:	58                   	pop    eax
 80490fc:	88 01                	mov    BYTE PTR [ecx],al
 80490fe:	41                   	inc    ecx
 80490ff:	84 c0                	test   al,al
 8049101:	74 02                	je     8049105 <_numtostr.terminar>
 8049103:	eb f6                	jmp    80490fb <_numtostr.cargar_en_memoria>

08049105 <_numtostr.terminar>:
 8049105:	c9                   	leave  
 8049106:	c3                   	ret    

08049107 <_print_array>:
 8049107:	55                   	push   ebp
 8049108:	89 e5                	mov    ebp,esp
 804910a:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
 804910d:	84 c9                	test   cl,cl
 804910f:	74 32                	je     8049143 <_print_array.terminar>
 8049111:	b8 04 00 00 00       	mov    eax,0x4
 8049116:	f7 e1                	mul    ecx
 8049118:	50                   	push   eax
 8049119:	b9 00 00 00 00       	mov    ecx,0x0

0804911e <_print_array.ciclo>:
 804911e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 8049121:	01 c8                	add    eax,ecx
 8049123:	8b 5d 10             	mov    ebx,DWORD PTR [ebp+0x10]
 8049126:	53                   	push   ebx
 8049127:	ff 30                	push   DWORD PTR [eax]
 8049129:	e8 95 ff ff ff       	call   80490c3 <numtostr>
 804912e:	83 c4 04             	add    esp,0x4
 8049131:	5b                   	pop    ebx
 8049132:	e8 39 ff ff ff       	call   8049070 <print>
 8049137:	83 c1 04             	add    ecx,0x4
 804913a:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 804913d:	39 c8                	cmp    eax,ecx
 804913f:	74 02                	je     8049143 <_print_array.terminar>
 8049141:	eb db                	jmp    804911e <_print_array.ciclo>

08049143 <_print_array.terminar>:
 8049143:	83 c4 04             	add    esp,0x4
 8049146:	c9                   	leave  
 8049147:	c3                   	ret    

08049148 <print_array>:
 8049148:	55                   	push   ebp
 8049149:	89 e5                	mov    ebp,esp
 804914b:	60                   	pusha  
 804914c:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 804914f:	50                   	push   eax
 8049150:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
 8049153:	50                   	push   eax
 8049154:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 8049157:	50                   	push   eax
 8049158:	e8 aa ff ff ff       	call   8049107 <_print_array>
 804915d:	83 c4 0c             	add    esp,0xc
 8049160:	61                   	popa   
 8049161:	5d                   	pop    ebp
 8049162:	c3                   	ret    

Disassembly of section .data:

0804a000 <my_string_divider>:
 804a000:	3d 3d 3d 3d 3d       	cmp    eax,0x3d3d3d3d
 804a005:	3d 3d 3d 3d 00       	cmp    eax,0x3d3d3d

0804a00a <mensaje>:
 804a00a:	3d 3d 3d 3d 3d       	cmp    eax,0x3d3d3d3d
 804a00f:	3d 3d 3d 20 45       	cmp    eax,0x45203d3d
 804a014:	4c                   	dec    esp
 804a015:	20 55 53             	and    BYTE PTR [ebp+0x53],dl
 804a018:	45                   	inc    ebp
 804a019:	52                   	push   edx
 804a01a:	20 41 43             	and    BYTE PTR [ecx+0x43],al
 804a01d:	54                   	push   esp
 804a01e:	55                   	push   ebp
 804a01f:	41                   	inc    ecx
 804a020:	4c                   	dec    esp
 804a021:	20 45 53             	and    BYTE PTR [ebp+0x53],al
 804a024:	3a 00                	cmp    al,BYTE PTR [eax]

0804a026 <my_warning>:
 804a026:	21 21                	and    DWORD PTR [ecx],esp
 804a028:	21 21                	and    DWORD PTR [ecx],esp
 804a02a:	21 21                	and    DWORD PTR [ecx],esp
 804a02c:	21 21                	and    DWORD PTR [ecx],esp
 804a02e:	53                   	push   ebx
 804a02f:	49                   	dec    ecx
 804a030:	20 4e 4f             	and    BYTE PTR [esi+0x4f],cl
 804a033:	20 4c 45 20          	and    BYTE PTR [ebp+eax*2+0x20],cl
 804a037:	50                   	push   eax
 804a038:	41                   	inc    ecx
 804a039:	53                   	push   ebx
 804a03a:	41                   	inc    ecx
 804a03b:	53                   	push   ebx
 804a03c:	20 41 52             	and    BYTE PTR [ecx+0x52],al
 804a03f:	47                   	inc    edi
 804a040:	55                   	push   ebp
 804a041:	4d                   	dec    ebp
 804a042:	45                   	inc    ebp
 804a043:	4e                   	dec    esi
 804a044:	54                   	push   esp
 804a045:	4f                   	dec    edi
 804a046:	53                   	push   ebx
 804a047:	20 41 4c             	and    BYTE PTR [ecx+0x4c],al
 804a04a:	20 4c 4c 41          	and    BYTE PTR [esp+ecx*2+0x41],cl
 804a04e:	4d                   	dec    ebp
 804a04f:	41                   	inc    ecx
 804a050:	44                   	inc    esp
 804a051:	4f                   	dec    edi
 804a052:	20 53 45             	and    BYTE PTR [ebx+0x45],dl
 804a055:	20 52 4f             	and    BYTE PTR [edx+0x4f],dl
 804a058:	4d                   	dec    ebp
 804a059:	50                   	push   eax
 804a05a:	45                   	inc    ebp
 804a05b:	21 21                	and    DWORD PTR [ecx],esp
 804a05d:	21 21                	and    DWORD PTR [ecx],esp
 804a05f:	20 50 41             	and    BYTE PTR [eax+0x41],dl
 804a062:	4a                   	dec    edx
 804a063:	41                   	inc    ecx
 804a064:	20 41 52             	and    BYTE PTR [ecx+0x52],al
 804a067:	52                   	push   edx
 804a068:	45                   	inc    ebp
 804a069:	47                   	inc    edi
 804a06a:	4c                   	dec    esp
 804a06b:	41                   	inc    ecx
 804a06c:	52                   	push   edx
 804a06d:	4c                   	dec    esp
 804a06e:	4f                   	dec    edi
 804a06f:	21 21                	and    DWORD PTR [ecx],esp
 804a071:	21 00                	and    DWORD PTR [eax],eax

Disassembly of section .bss:

0804a074 <my_string_memory>:
	...
