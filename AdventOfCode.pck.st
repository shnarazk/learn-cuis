'From Cuis 6.0 [latest update: #5202] on 27 May 2022 at 2:45:18 pm'!
'Description day11'!
!provides: 'AdventOfCode' 1 15!
SystemOrganization addCategory: 'AdventOfCode-Day11-Test'!
SystemOrganization addCategory: 'AdventOfCode-Day11'!


!classDefinition: #Day11StateTest category: 'AdventOfCode-Day11-Test'!
TestCase subclass: #Day11StateTest
	instanceVariableNames: 'aStart aGoal example'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AdventOfCode-Day11-Test'!
!classDefinition: 'Day11StateTest class' category: 'AdventOfCode-Day11-Test'!
Day11StateTest class
	instanceVariableNames: ''!

!classDefinition: #Day11State category: 'AdventOfCode-Day11'!
Object subclass: #Day11State
	instanceVariableNames: 'code cost estimatedCost'
	classVariableNames: 'Goal Kinds NumberOfObjects Width'
	poolDictionaries: ''
	category: 'AdventOfCode-Day11'!
!classDefinition: 'Day11State class' category: 'AdventOfCode-Day11'!
Day11State class
	instanceVariableNames: ''!


!Day11State commentStamp: '<historical>' prior: 0!
Compressed state description!

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 11:49:56'!
setUp
	Day11State setKinds: 2.
	aStart _ Day11State new.
	aGoal _ Day11State new initializeAs: 1023.
	example _ Day11State represents:
		{1. 0. 2. 0}.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 13:57:15'!
testAdjacentFloors
	self
		assert:
			{1}
		equals: aStart adjacentFloors.
	self
		assert:
			{2}
		equals: aGoal adjacentFloors.
	example floorOfElevator: 1.
	self
		assert:
			{0. 2}
		equals: example adjacentFloors.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 11:29:39'!
testCostToGoal
	
	self
		assert: 11
		equals: example costToGoal.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 13:23:40'!
testFloorOfElevator
	example floorOfElevator: 3.
	self
		assert: 3
		equals: example floorOfElevator.
	example floorOfElevator: 1.
	self
		assert: 1
		equals: example floorOfElevator.
	example floorOfElevator: 2.
	self
		assert: 2
		equals: example floorOfElevator.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 11:48:09'!
testFloorOfObject
	self
		assert: 0
		equals: (example floorOfObject: 1).
	self
		assert: 1
		equals: (example floorOfObject: 2).
	self
		assert: 0
		equals: (example floorOfObject: 3).
	self
		assert: 2
		equals: (example floorOfObject: 4).
	self
		assert: 0
		equals: (example floorOfObject: 5).
	self
		assert: 1
		equals: (example floorOfObject: (example objectIndexOfGenerator: 1)).
	self
		assert: 0
		equals: (example floorOfObject: (example objectIndexOfChip: 1)).
	self
		assert: 2
		equals: (example floorOfObject: (example objectIndexOfGenerator: 2)).
	self
		assert: 0
		equals: (example floorOfObject: (example objectIndexOfChip: 2)).
	self assert: 3 equals: (aGoal floorOfObject: 1).! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 13:12:58'!
testFloorOfObjectTo
	example
		floorOfObject: 2
		to: 3.
	self assert: 3 equals: (example floorOfObject: 2).
	example
		floorOfObject: 3
		to: 2.
	self assert: 2 equals: (example floorOfObject: 3).
	example
		floorOfObject: 4
		to: 1.
	self assert: 1 equals: (example floorOfObject: 4).
	example
		floorOfObject: 5
		to: 0.
	self assert: 0 equals: (example floorOfObject: 5).! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 11:30:34'!
testIsGoal
	"a test"
	self
		assert: false
		equals: aStart isGoal.
	self
		assert: true
		equals: aGoal isGoal.
		! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 13:28:54'!
testIsSafe
	self
		assert: true
		equals: aStart isSafe.
	self
		assert: true
		equals: aGoal isSafe.
	self
		assert: true
		equals: example isSafe.! !

!Day11StateTest methodsFor: 'testing' stamp: 'shnarazk 5/27/2022 07:56:19'!
testNeighbarStates
| states |
states _ aStart neighborStates .
self assert: states isEmpty equals: false.! !

!Day11StateTest class methodsFor: 'instance creation' stamp: 'shnarazk 5/27/2022 01:53:47'!
aStart
	Day11State setKinds: 2.	
	^Day11State new.! !

!Day11State methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 12:09:33'!
code
^code! !

!Day11State methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 09:07:23'!
cost
^cost! !

!Day11State methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 14:13:19'!
cost: aCost
	| g c |
	cost _ aCost.
	"And update the estimated cost"
	g _ 0.
	c _ 0.
	1
		to: self class kinds
		do: [ :kind |
			g _ g + 3 - (self floorOfGenerator: kind).
			c _ c + 3 - (self floorOfChip: kind) ].
	estimatedCost _ cost + g + (c * 2).! !

!Day11State methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 09:07:37'!
estimatedCost
^estimatedCost ! !

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

!Day11State methodsFor: 'initialization' stamp: 'shnarazk 5/27/2022 12:00:17'!
initialize
	"every instance is initialized as being a start."
	super initialize.
	code _ 0.
	cost  _ 0.
	estimatedCost _ 0.! !

!Day11State methodsFor: 'initialization' stamp: 'shnarazk 5/25/2022 20:07:00'!
initializeAs: anIndex
	self initialize.
	code _ anIndex.! !

!Day11State methodsFor: 'associating' stamp: 'shnarazk 5/27/2022 14:05:38'!
neighborStates
	"the main logic"
	| floor result |
	result _ Set new.
	floor _ self floorOfElevator.
	self
		allObjectPairsOn: floor
		do: [ :i :j |
		
			self adjacentFloors do: [ :f | | newState |
				newState _ self
					moveTo: f
					with: i
					and: j.
				newState isSafe ifTrue: [ result add: newState ]]].
	^ result.! !

!Day11State methodsFor: 'evaluating' stamp: 'shnarazk 5/27/2022 13:57:52'!
costToGoal
	| visit toCheck depth |
	depth _ 0.
	visit _ Set new.
	toCheck _ Heap new.
	toCheck add: self.
	[ toCheck isEmpty ] whileFalse: [ | state |
		state _ toCheck removeFirst.
		state isGoal ifTrue: [ ^ state cost ].
		(visit includes: state code) ifFalse: [
			visit add: state code.
			depth _ depth max: state cost.
			state neighborStates do: [ :each |
				toCheck add: each ]]].
	Transcript
		show: 'visit: ' , visit size asString;
		cr.
	Transcript
		show: 'depth: ' , depth asString;
		cr.
	self error: 'wrong calculation'.! !

!Day11State methodsFor: 'evaluating' stamp: 'shnarazk 5/25/2022 20:53:05'!
isGoal
	^ code = self class goal ! !

!Day11State methodsFor: 'evaluating' stamp: 'shnarazk 5/27/2022 13:41:33'!
isSafe
	1
		to: self class kinds
		do: [ :k | | floor |
			floor _ self floorOfChip: k.
			(self floorOfGenerator: k) = floor ifFalse: [
				1
					to: self class kinds
					do: [ :i |
						(self floorOfGenerator: i) = floor ifTrue: [
							
							^ false ]]]].
	^ true.! !

!Day11State methodsFor: 'comparing' stamp: 'shnarazk 5/27/2022 09:07:54'!
<= other
	^ estimatedCost <= other estimatedCost ! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 13:56:55'!
adjacentFloors
	| floor |
	floor _ self floorOfElevator.
	floor = 0 ifTrue: [ ^ {1} ].
	floor = 3 ifTrue: [ ^ {2} ].
	^ {floor - 1 . floor + 1}.! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 13:01:57'!
allObjectPairsOn: floor do: aBlock
	"all but elevator"
	| objects |
	objects _ self class numberOfObjects .
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

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 13:49:25'!
allObjectsOn: floor do: aBlock
	"not in use"
	"all but elevator"
	2
		to: self class numberOfObjects
		do: [ :i |
	
			i = floor ifTrue: [ aBlock value: i ]].! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 11:38:53'!
floorOfObject: anObject
	| mask result |
	mask _ (self class numberOfObjects - anObject) * 2.
	mask _ 2 << mask.
	result _ (code bitAnd: mask) > 0
		ifTrue: [ 2 ]
		ifFalse: [ 0 ].
	mask _ mask >> 1.
	(code bitAnd: mask) > 0
		ifTrue: [ ^ result + 1 ]
		ifFalse: [ ^ result ].! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 11:39:03'!
floorOfObject: anObject to: floor
	| mask |
	mask _ self class numberOfObjects - anObject * 2.
	mask _ 2 << mask.
	code _ code bitClear: mask.
	floor > 1 ifTrue: [ code _ code bitOr: mask ].
	mask _ mask >> 1.
	code _ code bitClear: mask.
	floor odd ifTrue: [ code _ code bitOr: mask ].! !

!Day11State methodsFor: 'private' stamp: 'shnarazk 5/27/2022 13:17:00'!
moveTo: floor with: anObjest and: anotherObject
	| state |
	state _ self class new initializeAs: code.
	state floorOfElevator: floor.
	state
		floorOfObject: anObjest
		to: floor.
	state
		floorOfObject: anotherObject
		to: floor.
	state cost: self cost + 1.
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

!Day11State class methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 11:21:20'!
numberOfObjects
^NumberOfObjects ! !

!Day11State class methodsFor: 'accessing' stamp: 'shnarazk 5/27/2022 11:52:23'!
setKinds: k
	Kinds _ k.
	"Generator and Microchip, plus elevator"
	Width _ k * 2 + 1.
	NumberOfObjects _ k * 2 + 1.
	Goal _ 4 ^ NumberOfObjects - 1.! !

!Day11State class methodsFor: 'instance creation' stamp: 'shnarazk 5/27/2022 09:28:21'!
newAs: aCode
	| instance |
	instance _ self new.
	instance initializeAs: aCode.
	^ instance.! !

!Day11State class methodsFor: 'instance creation' stamp: 'shnarazk 5/27/2022 09:41:59'!
represents: vec
	| code |
	code _ vec inject: 0 into: [ :total :val | (total * 4) + val].
	^self newAs: code! !

!Day11State class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/27/2022 14:03:57'!
part1
	| start |
	Day11State setKinds: 5.
	start _ Day11State represents:
		{0. 0. 0. 0. 1. 2. 1. 1. 1. 1}.
	Transcript show: start costToGoal .! !

!Day11State class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/27/2022 14:04:14'!
part2
	| start |
	Day11State setKinds: 7.
	start _ Day11State represents:
		{0. 0. 0. 0. 1. 2. 1. 1. 1. 1. 0. 0. 0. 0. }.
	Transcript show: start costToGoal.! !
