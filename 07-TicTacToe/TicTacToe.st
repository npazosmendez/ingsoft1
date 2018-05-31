!classDefinition: #TicTacToeTest category: #TicTacToStep21!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:46:50'!
test01MarkedPositionsAreEmptyInANewGame

	|game|
	
	game := TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:49:05'!
test02XCanPlayFirst

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: game Os isEmpty.
	
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:49:18'!
test03OCanPlayAfterX

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: 1 equals: game Os size.
	self assert: (game Os includes: 2@2).
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:49:35'!
test04XCanNotPlayTwice

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:49:48'!
test05OCanNotPlayTwice

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putOAt: 3@3]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:52:33'!
test06XCanNotPlayWhereXPlayedBefore

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putXAt: 1@1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:52:40'!
test07XCanNotPlayWhereOPlayedBefore

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:52:25'!
test09OCanNotPlayWhereSomeonePlayedBefore

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	self
	should: [game putOAt: 2@2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.	
		self assert: 2 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Xs includes: 3@3).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:54:58'!
test10NobodyWinsIfThereIsNotThreeInARow

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	
		self deny: game OHasWon.
		self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:57:23'!
test11XWinsIfTheyCompleteTheFirstColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:57:33'!
test12XWinsIfTheyCompleteTheSecondColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 2@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:58:37'!
test13XWinsIfTheyCompleteTheThirdColumn

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:57:49'!
test14XWinsIfTheyCompleteARow

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:59:07'!
test15XWinsIfTheyCompleteTheRegularDiagonal

	|game|
	
	game := TicTacToe new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	game putXAt: 3@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:59:12'!
test16XWinsIfTheyCompleteTheReverseDiagonal

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 1@3.
	
	
		self assert: game XHasWon.
		self deny: game OHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 21:59:31'!
test17OWinsIfTheyCompleteThreeInARow

	|game|
	
	game := TicTacToe new.

	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	game putOAt: 1@3.
	
		self assert: game OHasWon.
		self deny: game XHasWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:00:15'!
test18OCanNotPlayWhenXHasWon

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.	
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@1.	
	game putXAt: 1@3.

	self 
		should: [ game putOAt: 3@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:00:39'!
test19XCanNotPlayWhenOHasWon

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 1@3.

	self 
		should: [ game putXAt: 3@2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game Xs size.
			self assert: (game Xs includes: 2@2).
			self assert: (game Xs includes: 2@1).
			self assert: (game Xs includes: 3@1) ]
			
			! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:01:19'!
test20GameIsTiedIfNobodyCompletesThreeInARow

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.	
	game putOAt: 2@3.
	game putXAt: 1@2.	
	game putOAt: 3@2.
	game putXAt: 3@3.
	
	self assert: game isOver.
	self deny: game XHasWon. 
	self deny: game OHasWon. 
	self assert: game isTied
! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:04:02'!
test21GameIsOverIfAPlayerWins

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@2.	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	game putXAt: 3@2.	
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game XHasWon. 
	self deny: game OHasWon. 
	self deny: game isTied
! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:05:36'!
test90OCanNotPlayFirst

	|game|
	
	game := TicTacToe new.

	self
	should: [game putOAt: 3@3]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError|
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.	
		self assert: 0 equals: game Xs size.
		self assert: 0 equals: game Os size.
		].
	! !

!TicTacToeTest methodsFor: 'tests' stamp: 'DR 5/30/2018 22:04:13'!
test91GameIsOverIfTheGameIsTied

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@2.	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	game putXAt: 3@2.	
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game isOver.! !


!classDefinition: #TicTacToe category: #TicTacToStep21!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToe methodsFor: 'basic endgame' stamp: 'jg 5/22/2018 12:51:23'!
hasCompletedColumn: positions
	
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ]! !

!TicTacToe methodsFor: 'basic endgame' stamp: 'jg 5/22/2018 12:36:01'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'basic endgame' stamp: 'jg 5/22/2018 12:56:21'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]
! !

!TicTacToe methodsFor: 'basic endgame' stamp: 'DR 5/31/2018 00:57:48'!
hasTie
	
	^xs size = 5 and: [ os size = 4 and: [ self XHasWon not ]] " and: [ self YHasWon not ]]]"! !

!TicTacToe methodsFor: 'basic endgame' stamp: 'jg 5/22/2018 13:02:13'!
hasUpDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'basic endgame' stamp: 'jg 5/22/2018 13:01:53'!
hasWin: positions

	^(self hasCompletedRow: positions)
		or: [(self hasCompletedColumn: positions) 
				or: [(self hasDownDiagonal: positions)
					or: [(self hasUpDiagonal: positions)]]]


! !


!TicTacToe methodsFor: 'endgame' stamp: 'DR 5/31/2018 00:51:09'!
OHasWon
	
	^state OHasWon! !

!TicTacToe methodsFor: 'endgame' stamp: 'DR 5/31/2018 01:00:20'!
XHasWon
	
	^state XHasWon! !

!TicTacToe methodsFor: 'endgame' stamp: 'DR 5/31/2018 00:19:05'!
isOver
	
	^state isOver
! !

!TicTacToe methodsFor: 'endgame' stamp: 'DR 5/31/2018 01:00:35'!
isTied
	
	^state isTied ! !


!TicTacToe methodsFor: 'initialization' stamp: 'DR 5/31/2018 00:18:18'!
initialize
	
	xs:= Set new.
	os:= Set new.
	
	state := TicTacToeXTurn new.! !


!TicTacToe methodsFor: 'private' stamp: 'DR 5/31/2018 01:03:39'!
addNewPosition: aPosition toList: aListOfPositions
	
	self raiseErrorIfPositionTaken: aPosition.
	aListOfPositions add: aPosition.! !

!TicTacToe methodsFor: 'private' stamp: 'DR 5/30/2018 23:51:25'!
os

	^os! !

!TicTacToe methodsFor: 'private' stamp: 'DR 5/31/2018 00:18:23'!
state: aTurn
	state _ aTurn.! !

!TicTacToe methodsFor: 'private' stamp: 'DR 5/30/2018 23:51:22'!
xs

	^xs! !


!TicTacToe methodsFor: 'positions' stamp: 'jg 5/22/2018 10:01:34'!
Os

	^os copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'jg 5/22/2018 10:01:25'!
Xs

	^xs copy.! !


!TicTacToe methodsFor: 'playing' stamp: 'DR 5/31/2018 00:18:31'!
putOAt: aPosition

	state putOAt: aPosition inGame: self! !

!TicTacToe methodsFor: 'playing' stamp: 'DR 5/31/2018 00:18:34'!
putXAt: aPosition

	state putXAt: aPosition inGame: self! !


!TicTacToe methodsFor: 'errors' stamp: 'DR 5/30/2018 23:51:01'!
raiseErrorIfPositionTaken: aPosition

	^((xs includes: aPosition) or: (os includes: aPosition)) ifTrue: [self error: self class positionTakenErrorMessage].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToStep21!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:15:31'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'DR 5/30/2018 20:15:22'!
notOTurnErrorMessage

	^'Not O turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:26:38'!
notXTurnErrorMessage

	^'Not X turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 11:20:12'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeState category: #TicTacToStep21!
Object subclass: #TicTacToeState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeState methodsFor: 'playing' stamp: 'DR 5/31/2018 00:51:57'!
OHasWon

	self shouldBeImplemented.! !

!TicTacToeState methodsFor: 'playing' stamp: 'DR 5/31/2018 00:15:35'!
putOAt: aPosition inGame: aGame

	self shouldBeImplemented.! !

!TicTacToeState methodsFor: 'playing' stamp: 'DR 5/31/2018 00:15:37'!
putXAt: aPosition inGame: aGame

	self shouldBeImplemented.! !


!TicTacToeState methodsFor: 'endgame' stamp: 'DR 5/31/2018 00:15:32'!
isOver

	self shouldBeImplemented.! !


!TicTacToeState methodsFor: 'transition' stamp: 'DR 5/31/2018 00:15:28'!
nextStateOf: aGame

	self shouldBeImplemented.! !


!classDefinition: #TicTacToeEnd category: #TicTacToStep21!
TicTacToeState subclass: #TicTacToeEnd
	instanceVariableNames: 'winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeEnd methodsFor: 'playing' stamp: 'DR 5/31/2018 00:16:12'!
putOAt: aPosition inGame: aGame

	self error: aGame class canNotPlayWhenGameIsOverErrorMessage.! !

!TicTacToeEnd methodsFor: 'playing' stamp: 'DR 5/31/2018 00:16:09'!
putXAt: aPosition inGame: aGame

	self error: aGame class canNotPlayWhenGameIsOverErrorMessage.! !


!TicTacToeEnd methodsFor: 'endgame' stamp: 'DR 5/31/2018 00:51:42'!
OHasWon

	^winner = #o! !

!TicTacToeEnd methodsFor: 'endgame' stamp: 'DR 5/31/2018 00:59:37'!
XHasWon

	^winner = #x! !

!TicTacToeEnd methodsFor: 'endgame' stamp: 'DR 5/30/2018 21:43:55'!
isOver

	^true! !

!TicTacToeEnd methodsFor: 'endgame' stamp: 'DR 5/31/2018 00:59:58'!
isTied

	^winner = nil! !


!TicTacToeEnd methodsFor: 'transition' stamp: 'DR 5/31/2018 00:16:16'!
nextStateOf: aGame

	self shouldNotImplement.! !


!TicTacToeEnd methodsFor: 'initialization' stamp: 'DR 5/31/2018 00:39:20'!
initializeWith: aWinner

	winner _ aWinner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeEnd class' category: #TicTacToStep21!
TicTacToeEnd class
	instanceVariableNames: ''!

!TicTacToeEnd class methodsFor: 'instanciation' stamp: 'DR 5/31/2018 00:40:17'!
withTie

	^self new! !

!TicTacToeEnd class methodsFor: 'instanciation' stamp: 'DR 5/31/2018 00:40:31'!
withWinner: aWinner

	^self new initializeWith: aWinner! !


!classDefinition: #TicTacToeTurn category: #TicTacToStep21!
TicTacToeState subclass: #TicTacToeTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeTurn methodsFor: 'endgame' stamp: 'DR 5/31/2018 00:52:02'!
OHasWon

	^false! !

!TicTacToeTurn methodsFor: 'endgame' stamp: 'DR 5/31/2018 01:00:05'!
XHasWon

	^false! !

!TicTacToeTurn methodsFor: 'endgame' stamp: 'DR 5/30/2018 22:19:15'!
isOver

	^false! !

!TicTacToeTurn methodsFor: 'endgame' stamp: 'DR 5/31/2018 01:00:07'!
isTied

	^false! !


!classDefinition: #TicTacToeOTurn category: #TicTacToStep21!
TicTacToeTurn subclass: #TicTacToeOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeOTurn methodsFor: 'playing' stamp: 'DR 5/31/2018 01:03:14'!
putOAt: aPosition inGame: aGame

	aGame
		addNewPosition: aPosition
		toList: aGame os.
	self nextStateOf: aGame.! !

!TicTacToeOTurn methodsFor: 'playing' stamp: 'DR 5/30/2018 23:53:29'!
putXAt: aPosition inGame: aGame

	self error: aGame class notXTurnErrorMessage.! !


!TicTacToeOTurn methodsFor: 'transition' stamp: 'DR 5/31/2018 00:58:02'!
nextStateOf: aGame

	(aGame hasWin: aGame os)
		ifTrue: [ aGame state: (TicTacToeEnd withWinner: #o) ]
		ifFalse: [
			(aGame hasTie)
				ifTrue: [ aGame state: TicTacToeEnd withTie ]
				ifFalse: [ aGame state: TicTacToeXTurn new ].
		]

		! !


!classDefinition: #TicTacToeXTurn category: #TicTacToStep21!
TicTacToeTurn subclass: #TicTacToeXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeXTurn methodsFor: 'playing' stamp: 'DR 5/30/2018 23:53:55'!
putOAt: aPosition inGame: aGame

	self error: aGame class notOTurnErrorMessage.! !

!TicTacToeXTurn methodsFor: 'playing' stamp: 'DR 5/31/2018 01:03:20'!
putXAt: aPosition inGame: aGame

	aGame
		addNewPosition: aPosition
		toList: aGame xs.
	self nextStateOf: aGame.! !


!TicTacToeXTurn methodsFor: 'transition' stamp: 'DR 5/31/2018 00:59:19'!
nextStateOf: aGame

	(aGame hasWin: aGame xs)
		ifTrue: [ aGame state: (TicTacToeEnd withWinner: #x) ]
		ifFalse: [
			(aGame hasTie)
				ifTrue: [ aGame state: TicTacToeEnd withTie ]
				ifFalse: [ aGame state: TicTacToeOTurn new ].
		]! !
