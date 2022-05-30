'From Cuis 6.0 [latest update: #5202] on 31 May 2022 at 8:45:02 am'!
'Description '!
!provides: 'RustBridge' 1 0!
SystemOrganization addCategory: 'RustBridge'!


!classDefinition: #RustCaller1 category: 'RustBridge'!
Object subclass: #RustCaller1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RustBridge'!
!classDefinition: 'RustCaller1 class' category: 'RustBridge'!
RustCaller1 class
	instanceVariableNames: ''!


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
