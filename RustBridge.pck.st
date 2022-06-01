'From Cuis 6.0 [latest update: #5202] on 1 June 2022 at 9:23:53 pm'!
'Description '!
!provides: 'RustBridge' 1 4!
SystemOrganization addCategory: 'RustBridge'!


!classDefinition: #B80 category: 'RustBridge'!
ExternalStructure subclass: #B80
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RustBridge'!
!classDefinition: 'B80 class' category: 'RustBridge'!
B80 class
	instanceVariableNames: ''!

!classDefinition: #RustCaller1 category: 'RustBridge'!
Object subclass: #RustCaller1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RustBridge'!
!classDefinition: 'RustCaller1 class' category: 'RustBridge'!
RustCaller1 class
	instanceVariableNames: ''!


!B80 methodsFor: 'accessing'!
a0
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 1! !

!B80 methodsFor: 'accessing'!
a0: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 1 put: anObject! !

!B80 methodsFor: 'accessing'!
b1
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 2! !

!B80 methodsFor: 'accessing'!
b1: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 2 put: anObject! !

!B80 methodsFor: 'accessing'!
b2
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 3! !

!B80 methodsFor: 'accessing'!
b2: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 3 put: anObject! !

!B80 methodsFor: 'accessing'!
b3
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 4! !

!B80 methodsFor: 'accessing'!
b3: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 4 put: anObject! !

!B80 methodsFor: 'accessing'!
b4
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 5! !

!B80 methodsFor: 'accessing'!
b4: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 5 put: anObject! !

!B80 methodsFor: 'accessing'!
b5
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 6! !

!B80 methodsFor: 'accessing'!
b5: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 6 put: anObject! !

!B80 methodsFor: 'accessing'!
b6
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 7! !

!B80 methodsFor: 'accessing'!
b6: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 7 put: anObject! !

!B80 methodsFor: 'accessing'!
b7
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 8! !

!B80 methodsFor: 'accessing'!
b7: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 8 put: anObject! !

!B80 methodsFor: 'accessing'!
b8
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 9! !

!B80 methodsFor: 'accessing'!
b8: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 9 put: anObject! !

!B80 methodsFor: 'accessing'!
b9
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	^handle unsignedByteAt: 10! !

!B80 methodsFor: 'accessing'!
b9: anObject
	"This method was automatically generated. See B80 class>>fields."
	<generated>
	handle unsignedByteAt: 10 put: anObject! !

!B80 class methodsFor: 'as yet unclassified' stamp: 'shnarazk 6/1/2022 21:15:06'!
fields
	^ #(
		#(#a0 'byte' )
		#(#b1 'byte' )
		#(#b2 'byte' )
		#(#b3 'byte' )
		#(#b4 'byte' )
		#(#b5 'byte' )
		#(#b6 'byte' )
		#(#b7 'byte' )
		#(#b8 'byte' )
		#(#b9 'byte' )
	).! !

!B80 class methodsFor: 'as yet unclassified' stamp: 'shnarazk 6/1/2022 21:13:53'!
initialize
super initialize .
self defineFields .! !

!RustCaller1 methodsFor: 'testing' stamp: 'shnarazk 5/31/2022 08:44:17'!
test1: aFloat
	<cdecl: double 'rustfunc1' (double) module: '/Users/nash/.cargo/shared-target/release/librust_ffi_demo.dylib'>
	^ self externalCallFailed.
! !

!RustCaller1 methodsFor: 'testing' stamp: 'shnarazk 5/31/2022 08:43:35'!
test2: aString
	"<cdecl: *char 'rustfunc2' (*char) module: '/Users/nash/.cargo/shared-target/release/librust_ffi_demo.dylib'>
	^ self externalCallFailed."
	^ self.! !

!RustCaller1 methodsFor: 'testing' stamp: 'shnarazk 6/1/2022 21:23:43'!
test3
	"I will return #(1 2 3 0) for now."
	| tmp |
	tmp _ self test3: B80 new.
	^ {tmp getHandle at: 1. tmp getHandle at: 2. tmp getHandle at: 3. tmp getHandle at: 4}.! !

!RustCaller1 methodsFor: 'testing' stamp: 'shnarazk 6/1/2022 21:19:30'!
test3: arg
	<cdecl: B80* 'rustfunc3' (B80*) module: '/Users/nash/.cargo/shared-target/release/librust_ffi_demo.dylib'>
	^ self externalCallFailed.! !
B80 initialize!
