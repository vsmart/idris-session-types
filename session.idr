module session

--Available actions are send and receive.
data sAct = Send Type
          | Rcv Type


--A program
data sProg : List sAct -> List sAct -> Type -> Type where
  End : sProg Nil Nil ()
  send : t -> sProg (Send t :: xs) xs t
  rcv  : sProg (Rcv t :: xs) xs t
  (>>=) : sProg xs xs' j -> (j -> sProg xs' xs'' k) -> sProg xs xs'' k
  return : t -> sProg xs xs t

sendTC : sProg [Send Int, Rcv Char] [] ()
sendTC = do send 94
            c <- rcv
            return ()

rcvTC : sProg [Send Char, Rcv Int] [] ()
rcvTC = do send 'c'
           i <- rcv 
           return ()


