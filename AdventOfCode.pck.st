'From Cuis 6.0 [latest update: #5171] on 26 May 2022 at 10:08:11 pm'!
'Description '!
!provides: 'AdventOfCode' 1 2!
SystemOrganization addCategory: 'AdventOfCode-Test'!
SystemOrganization addCategory: 'AdventOfCode'!


!classDefinition: #Day11StateCodeTest category: 'AdventOfCode-Test'!
TestCase subclass: #Day11StateCodeTest
	instanceVariableNames: 'aStart aGoal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AdventOfCode-Test'!
!classDefinition: 'Day11StateCodeTest class' category: 'AdventOfCode-Test'!
Day11StateCodeTest class
	instanceVariableNames: ''!

!classDefinition: #Day11StateCode category: 'AdventOfCode'!
Object subclass: #Day11StateCode
	instanceVariableNames: 'code cost estimatedCost'
	classVariableNames: 'Goal Kinds Width'
	poolDictionaries: ''
	category: 'AdventOfCode'!
!classDefinition: 'Day11StateCode class' category: 'AdventOfCode'!
Day11StateCode class
	instanceVariableNames: ''!


!Day11StateCode commentStamp: '<historical>' prior: 0!
Compressed state description!

!Day11StateCodeTest methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/26/2022 22:07:12'!
setUp
	Day11StateCode setKinds: 2.
	aStart _ Day11StateCode new.
	aGoal _ Day11StateCode new initializeAs: 255.! !

!Day11StateCodeTest methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/26/2022 22:02:12'!
testAdjacentFloors
	"a test"
	self
		
			assert: aStart adjacentFloors equals: { 1 }.! !

!Day11StateCodeTest methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/25/2022 20:12:23'!
testIsGoal
	"a test"
	self
		assert: aStart isGoal
		equals: false;
		assert: aGoal isGoal 
		equals: true.! !

!Day11StateCodeTest methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/25/2022 20:11:43'!
testIsStart
	"a test"
	self
		
			assert: aStart isStart
			equals: true.
	self
		
			assert: aGoal isStart
			equals: false.! !

!Day11StateCode methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 22:01:07'!
adjacentFloors
	| floor |
	floor _ self floor.
floor = 0 ifTrue: [ ^ {1 } ].
	floor = 3 ifTrue: [ ^ {2 } ].
	^ {floor - 1 , floor + 1}.! !

!Day11StateCode methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 22:05:37'!
floorOf: anObject
	| mask result |
	mask _ self class kinds * 2 - anObject + 1.
	mask _ 1 << mask.
	result _ (code bitAnd: mask) > 0
		ifTrue: [ 2 ]
		ifFalse: [ 0 ].
	mask _ mask >> 1.
	(code bitAnd: mask) > 0
		ifTrue: [ ^ result + 1 ]
		ifFalse: [ ^ result ].! !

!Day11StateCode methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 18:53:15'!
floorOf: kind to: floor
	| mask |
	mask _ self class kinds - kind * 2 + 1.
	mask _ 1 << mask.
	code _ code bitClear: mask.
	floor > 1 ifTrue: [ code _ code bitOr: mask ].
	mask _ mask >> 1.
	code _ code bitClear: mask.
	floor odd ifTrue: [ code _ code bitOr: mask ].! !

!Day11StateCode methodsFor: 'converting' stamp: 'shnarazk 5/26/2022 18:14:29'!
expand
"return Arrayed version"
	self notYetImplemented.! !

!Day11StateCode methodsFor: 'initialization' stamp: 'shnarazk 5/25/2022 20:07:50'!
initialize
"every instance is initialized as being a start."
	super initialize.
	code _ 0.! !

!Day11StateCode methodsFor: 'initialization' stamp: 'shnarazk 5/25/2022 20:07:00'!
initializeAs: anIndex
	self initialize.
	code _ anIndex.! !

!Day11StateCode methodsFor: 'associating' stamp: 'shnarazk 5/26/2022 20:58:59'!
allObjectPairsOn: floor do: aBlock
	"all but elevator"
	| objects |
	objects _ self class kinds * 2.
	2
		to: objects
		do: [ :i |
			i = floor ifTrue: [
				2
					to: objects
					do: [ :j |
						j = floor ifTrue: [ aBlock value: i value: j ]]]].! !

!Day11StateCode methodsFor: 'associating' stamp: 'shnarazk 5/26/2022 20:55:15'!
allObjectsOn: floor do: aBlock
	2 "all but elevator"
		to: self class kinds * 2
		do: [ :i |
			i = floor ifTrue: [ aBlock value: i ]].! !

!Day11StateCode methodsFor: 'associating' stamp: 'shnarazk 5/26/2022 21:55:19'!
neighborStates
	"the main logic"
	| floor result |
	result _ Set new.
	floor _ self floorOf: 1.
	self
		allObjectPairsOn: floor
		do: [ :i :j |
			self adjacentFloors do: [ :f | | newState |
				newState _ self
					moveTo: f
					with: i
					and: j.
				newState isSafe ifTrue: [ result add: newState ]]].
		^result! !

!Day11StateCode methodsFor: 'evaluating' stamp: 'shnarazk 5/25/2022 20:53:05'!
isGoal
	^ code = self class goal ! !

!Day11StateCode methodsFor: 'evaluating' stamp: 'shnarazk 5/26/2022 18:55:33'!
isSafe
self notYetImplemented .! !

!Day11StateCode methodsFor: 'evaluating' stamp: 'shnarazk 5/25/2022 20:08:28'!
isStart
^ code = 0! !

!Day11StateCode methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/26/2022 21:56:19'!
floor
^self floorOf: 1! !

!Day11StateCode methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/26/2022 19:55:35'!
moveTo: floor with: anObjest and: anotherObject
self notYetImplemented ! !

!Day11StateCode class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/25/2022 20:51:58'!
goal
^Goal ! !

!Day11StateCode class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/26/2022 22:03:41'!
kinds
^Kinds ! !

!Day11StateCode class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/26/2022 18:02:44'!
setKinds: k
Kinds _ k.
	Width _ k + 1 * 2.
	Goal _ 2 ^ Width - 1.! !

!Day11StateCode class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/25/2022 20:57:43'!
setWidth: aWidth
	Width _ aWidth.
	Goal _ 2 ^ aWidth - 1.! !

!Day11StateCode class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/25/2022 20:49:33'!
width
^ Width! !
