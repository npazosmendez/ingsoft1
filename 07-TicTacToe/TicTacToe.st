!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:13:27'!
test01

	| game |
	
	game _ TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:19:05'!
test02

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:21:21'!
test03

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	
	self assert: 1 equals: game Os size.
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: (game Os includes: 2@1).! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:39:49'!
test04

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	
	self should: [game putXAt: 2@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:45:03'!
test05

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
		
	self should: [game putOAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@1).
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:52:52'!
test06

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
		
	self should: [game putXAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:04:37'!
test07

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
		
	self should: [game putOAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:54:59'!
test08

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
		
	self should: [game putOAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:58:00'!
test09

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
		
	self should: [game putOAt: 2@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 2 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Xs includes: 1@2).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@1).
	].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:24:09'!
test10

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	
	self deny: game OHasWon.
	self deny: game XHasWon.
		! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:36:29'!
test11

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:47:18'!
test12

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	game putXAt: 2@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:47:28'!
test13

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:02:40'!
test14

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:03:47'!
test15

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 1@3.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:04:59'!
test16

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:22:25'!
test17

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@2.
	game putXAt: 3@1.
	game putOAt: 1@3.
	
	self deny: game XHasWon.
	self assert: game OHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:28:40'!
test18

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	game putXAt: 3@1.
	
	self should: [game putOAt: 3@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 2@3). ]! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:35:11'!
test19

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 3@1.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	
	self should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game Xs size.
			self assert: (game Xs includes: 1@1).
			self assert: (game Xs includes: 1@2).
			self assert: (game Xs includes: 2@1).
			self assert: 3 equals: game Os size.
			self assert: (game Os includes: 3@1).
			self assert: (game Os includes: 3@2).
			self assert: (game Os includes: 3@3).
		]! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:42:35'!
test20

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game isOver.
	self deny: game XHasWon.
	self deny: game OHasWon.
	self assert: game isTied.
	
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:48:12'!
test21

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game putXAt: 3@2.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game isOver.
	self assert: game XHasWon.
	self deny: game OHasWon.
	self deny: game isTied.
	
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:58:36'!
test22

	| game |
	
	game _ TicTacToe new.
	
	game putXAt: 1@2.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 2@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	
	self deny: game XHasWon.
	self assert: game OHasWon.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'xs os turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:00:17'!
OHasWon
	^self oHasCompletedRow or:
		[ self oHasCompletedColumn or: [
				self oHasCompletedRegularDiagonal or: [
					self oHasCompletedReverseDiagonal ]]]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:24:39'!
Os
	^os copy! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 20:00:06'!
XHasWon
	^self xHasCompletedRow or:
		[ self xHasCompletedColumn or: [
				self xHasCompletedRegularDiagonal or: [
					self xHasCompletedReverseDiagonal ]]]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:24:33'!
Xs
	^xs copy! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:35:40'!
initialize
	xs _ Set new.
	os _ Set new.
	turn _ #x.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:43:53'!
isOver
	^self XHasWon or: [self OHasWon or: [ (os, xs) size = 9 ] ].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:44:54'!
isTied
	^self isOver and: ((self OHasWon or: self XHasWon) not).! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:59:18'!
oHasCompletedColumn
	^(1 to: 3) anySatisfy: [:y | (os count: [:position | position y = y ]) = 3 ]
	! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:59:29'!
oHasCompletedRegularDiagonal
	^(os includes: 1@1) and: (os includes: 2@2) and: (os includes: 3@3)
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:59:39'!
oHasCompletedReverseDiagonal
	^(os includes: 1@3) and: (os includes: 2@2) and: (os includes: 3@1)
	
	
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:59:45'!
oHasCompletedRow
	^(1 to: 3) anySatisfy: [:x | (os count: [:position | position x = x ]) = 3 ]
		
	
	
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:27:30'!
putOAt: aPoint
	((self XHasWon) or: self OHasWon) ifTrue: [self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	turn = #o ifFalse: [self error: self class notOTurnErrorMessage].
	
	((xs includes: aPoint) or: (os includes: aPoint)) ifTrue: [self error: self class positionTakenErrorMessage].
	
	os add: aPoint.
	turn _ #x.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:27:41'!
putXAt: aPoint
	((self XHasWon) or: self OHasWon) ifTrue: [self error: self class canNotPlayWhenGameIsOverErrorMessage ].
	turn = #x ifFalse: [self error: self class notXTurnErrorMessage].

	((xs includes: aPoint) or: (os includes: aPoint)) ifTrue: [self error: self class positionTakenErrorMessage].

	xs add: aPoint.
	turn _ #o.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:58:55'!
xHasCompletedColumn
	^(1 to: 3) anySatisfy: [:y | (xs count: [:position | position y = y ]) = 3 ]
	! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:58:59'!
xHasCompletedRegularDiagonal
	^(xs includes: 1@1) and: (xs includes: 2@2) and: (xs includes: 3@3)
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:59:03'!
xHasCompletedReverseDiagonal
	^(xs includes: 1@3) and: (xs includes: 2@2) and: (xs includes: 3@1)
	
	
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'DR 5/27/2018 19:59:07'!
xHasCompletedRow
	^(1 to: 3) anySatisfy: [:x | (xs count: [:position | position x = x ]) = 3 ]
		
	
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 21:26:05'!
canNotPlayWhenGameIsOverErrorMessage
	^'el juego terminó'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:25:41'!
new
	^self basicNew initialize! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:49:10'!
notOTurnErrorMessage
	^'O no va'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 19:49:12'!
notXTurnErrorMessage
	^'X no va'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/24/2018 20:02:17'!
positionTakenErrorMessage
	^'Posición ocupada'! !
