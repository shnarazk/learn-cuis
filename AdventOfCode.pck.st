'From Cuis 6.0 [latest update: #5202] on 27 May 2022 at 8:07:18 am'!
'Description day11'!
!provides: 'AdventOfCode' 1 6!
SystemOrganization addCategory: 'AdventOfCode-Day11-Test'!
SystemOrganization addCategory: 'AdventOfCode-Day11'!


!classDefinition: #Day11StateTest category: 'AdventOfCode-Day11-Test'!
TestCase subclass: #Day11StateTest
	instanceVariableNames: 'aStart aGoal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AdventOfCode-Day11-Test'!
!classDefinition: 'Day11StateTest class' category: 'AdventOfCode-Day11-Test'!
Day11StateTest class
	instanceVariableNames: ''!

!classDefinition: #Day11State category: 'AdventOfCode-Day11'!
Object subclass: #Day11State
	instanceVariableNames: 'code cost estimatedCost'
	classVariableNames: 'Goal Kinds Width'
	poolDictionaries: ''
	category: 'AdventOfCode-Day11'!
!classDefinition: 'Day11State class' category: 'AdventOfCode-Day11'!
Day11State class
	instanceVariableNames: ''!


!Day11State commentStamp: '<historical>' prior: 0!
Compressed state description!

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 01:53:47'!
setUp
	Day11State setKinds: 2.
	aStart _ Day11State new.
	aGoal _ Day11State new initializeAs: 63.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/26/2022 22:53:05'!
testAdjacentFloors
self assert: aStart adjacentFloors equals: { 1 }.
self assert: aGoal adjacentFloors equals: { 2 }.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/26/2022 23:52:25'!
testIsGoal
	"a test"
	self
		
			assert: aStart isGoal
			equals: false.
		self 
			assert: aGoal isGoal
			equals: true.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/25/2022 20:11:43'!
testIsStart
	"a test"
	self
		
			assert: aStart isStart
			equals: true.
	self
		
			assert: aGoal isStart
			equals: false.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 07:56:19'!
testNeighbarStates
| states |
states _ aStart neighborStates .
self assert: states isEmpty equals: false.! !

!Day11StateTest class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/27/2022 01:53:47'!
aStart
	Day11State setKinds: 2.	
	^Day11State new.! !

!Day11State methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 02:03:32'!
floorOfChip: kind
	| index |
	index _ self objectIndexOfChip: kind.
	^ self floorOfObject: index.! !

!Day11State methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 01:37:18'!
floorOfElevator
"I mean Elevator."
	^ self floorOfObject: 1.! !

!Day11State methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 01:38:19'!
floorOfElevator: aFloor
	^ self
		floorOfObject: 1
		to: aFloor.! !

!Day11State methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 02:03:05'!
floorOfGenerator: kind
| index |
	index _ self objectIndexOfGenerator: kind.
	^ self floorOfObject: index! !

!Day11State methodsFor: 'initialization' stamp: 'shnarazk 5/25/2022 20:07:50'!
initialize
"every instance is initialized as being a start."
	super initialize.
	code _ 0.! !

!Day11State methodsFor: 'initialization' stamp: 'shnarazk 5/25/2022 20:07:00'!
initializeAs: anIndex
	self initialize.
	code _ anIndex.! !

!Day11State methodsFor: 'associating' stamp: 'shnarazk 5/27/2022 08:06:32'!
neighborStates
	"the main logic"
	| floor result |
	result _ Set new.
	floor _ self floorOfElevator.
	Transcript show: floor.
	self
		allObjectPairsOn: floor
		do: [ :i :j |
			"Transcript show: i asString , ' - ' , j asString." self adjacentFloors do: [ :f | | newState |
				newState _ self
					moveTo: f
					with: i
					and: j.
				newState isSafe ifTrue: [ result add: newState ]]].
	^ result.! !

!Day11State methodsFor: 'evaluating' stamp: 'shnarazk 5/25/2022 20:53:05'!
isGoal
	^ code = self class goal ! !

!Day11State methodsFor: 'evaluating' stamp: 'shnarazk 5/27/2022 08:01:09'!
isSafe
	1
		to: self class kinds
		do: [ :k | | floor |
			floor _ self objectIndexOfChip: k.
			(self objectIndexOfGenerator: k) = k ifFalse: [
				1
					to: self class kinds
					do: [ :i |
						(self objectIndexOfGenerator: i) = floor ifTrue: [ ^ false ]]]].
	^ true.! !

!Day11State methodsFor: 'evaluating' stamp: 'shnarazk 5/25/2022 20:08:28'!
isStart
^ code = 0! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 01:37:18'!
adjacentFloors
	| floor |
	floor _ self floorOfElevator.
floor = 0 ifTrue: [ ^ {1 } ].
	floor = 3 ifTrue: [ ^ {2 } ].
	^ {floor - 1 , floor + 1}.! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 07:58:39'!
allObjectPairsOn: floor do: aBlock
	"all but elevator"
	| objects |
	objects _ self class kinds * 2.
	2
		to: objects
		do: [ :i |
			(self floorOfObject: i) = floor ifTrue: [
				i
					to: objects
					do: [ :j |
						(self floorOfObject: j) = floor ifTrue: [
							aBlock
								value: i
								value: j ]]]].! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 08:04:57'!
allObjectsOn: floor do: aBlock
"not in use"
	"all but elevator"
	2
		to: self class kinds * 2
		do: [ :i |
			Transcript show: 'fould'.
			i = floor ifTrue: [ aBlock value: i ]].! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/26/2022 23:44:06'!
floorOfObject: anObject
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

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 08:02:45'!
floorOfObject: anObject to: floor
	| mask |
	mask _ self class width - anObject * 2 + 1.
	mask _ 1 << mask.
	code _ code bitClear: mask.
	floor > 1 ifTrue: [ code _ code bitOr: mask ].
	mask _ mask >> 1.
	code _ code bitClear: mask.
	floor odd ifTrue: [ code _ code bitOr: mask ].! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 08:00:20'!
moveTo: floor with: anObjest and: anotherObject
	| state |
	state _ self class new initializeAs: code.
	state
		floorOfElevator: floor.
		
			state floorOfObject: anObjest
			to: floor.
		
			state floorOfObject: anotherObject
			to: floor.
	^ state.! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 01:34:43'!
objectIndexOfChip: k
	"index starts from 1 in Smalltalk. And 1 is used for Elevator."
	^ k * 2 + 1.! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 01:34:11'!
objectIndexOfGenerator: k
"index starts from 1 in Smalltalk. And 1 is used for Elevator."
^ k * 2! !

!Day11State class methodsFor: 'accessing' stamp: 'shnarazk 5/25/2022 20:51:58'!
goal
^Goal ! !

!Day11State class methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 22:03:41'!
kinds
^Kinds ! !

!Day11State class methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 18:02:44'!
setKinds: k
Kinds _ k.
	Width _ k + 1 * 2.
	Goal _ 2 ^ Width - 1.! !

!Day11State class methodsFor: 'accessing' stamp: 'shnarazk 5/25/2022 20:57:43'!
setWidth: aWidth
	Width _ aWidth.
	Goal _ 2 ^ aWidth - 1.! !

!Day11State class methodsFor: 'accessing' stamp: 'shnarazk 5/25/2022 20:49:33'!
width
^ Width! !

!Day11State class methodsFor: 'instance creation' stamp: 'shnarazk 5/26/2022 23:36:03'!
newWith: aCode
	| instance |
	instance _ self new.
	instance initializeAs: aCode.
	^ instance.! !
