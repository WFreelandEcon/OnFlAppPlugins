FasdUAS 1.101.10   ��   ��    k             l      ��  ��      
	match actions 
     � 	 	 $   
 	 m a t c h   a c t i o n s   
   
  
 l     ��������  ��  ��        i         I      �� ���� 0 matched_actions     ��  o      ���� 0 ctx  ��  ��    k     
       l     ��  ��    ( " get ACT_ variables from the 'ctx'     �   D   g e t   A C T _   v a r i a b l e s   f r o m   t h e   ' c t x '      l     ��  ��    5 / only relevant ACT_ variables will be passed in     �   ^   o n l y   r e l e v a n t   A C T _   v a r i a b l e s   w i l l   b e   p a s s e d   i n      l     ��������  ��  ��         r      ! " ! n      # $ # o    ���� 0 ACT_PATH   $ o     ���� 0 ctx   " o      ���� 0 	file_name      % & % l   ��������  ��  ��   &  ' ( ' l   �� ) *��   ) 0 * return missing value if there is no match    * � + + T   r e t u r n   m i s s i n g   v a l u e   i f   t h e r e   i s   n o   m a t c h (  ,�� , L    
 - - J    	 . .  /�� / m     0 0 � 1 1  C d   i n   T e r m i n a l��  ��     2 3 2 l     ��������  ��  ��   3  4 5 4 l      �� 6 7��   6 �
	carry on the action when user clicks the button
	
	    tell application "System Events"
        tell application process "Terminal"
            set frontmost to true
            keystroke cmd
            keystroke return
        end tell
    end tell
    7 � 8 8� 
 	 c a r r y   o n   t h e   a c t i o n   w h e n   u s e r   c l i c k s   t h e   b u t t o n 
 	 
 	         t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s " 
                 t e l l   a p p l i c a t i o n   p r o c e s s   " T e r m i n a l " 
                         s e t   f r o n t m o s t   t o   t r u e 
                         k e y s t r o k e   c m d 
                         k e y s t r o k e   r e t u r n 
                 e n d   t e l l 
         e n d   t e l l 
 5  9 : 9 l     ��������  ��  ��   :  ;�� ; i     < = < I      �� >���� 0 execute_action   >  ? @ ? o      ���� 0 nm   @  A�� A o      ���� 0 ctx  ��  ��   = k     $ B B  C D C O     ! E F E k      G G  H I H I   	������
�� .miscactvnull��� ��� null��  ��   I  J K J r   
  L M L n   
  N O N o    ���� 0 ACT_PATH   O o   
 ���� 0 ctx   M o      ���� 0 txt   K  P�� P I    �� Q R
�� .coredoscnull��� ��� ctxt Q b     S T S m     U U � V V  c d   T n     W X W 1    ��
�� 
strq X o    ���� 0 txt   R �� Y��
�� 
kfil Y n     Z [ Z 1    ��
�� 
tcnt [ 4    �� \
�� 
cwin \ m    ���� ��  ��   F m      ] ]�                                                                                      @ alis    l  Macintosh HD               Η��H+     PTerminal.app                                                     (��X!�        ����  	                	Utilities     Η��      �Xd       P   O  2Macintosh HD:Applications: Utilities: Terminal.app    T e r m i n a l . a p p    M a c i n t o s h   H D  #Applications/Utilities/Terminal.app   / ��   D  ^�� ^ L   " $ _ _ m   " #���� ��  ��       �� ` a b��   ` ������ 0 matched_actions  �� 0 execute_action   a �� ���� c d���� 0 matched_actions  �� �� e��  e  ���� 0 ctx  ��   c ������ 0 ctx  �� 0 	file_name   d �� 0�� 0 ACT_PATH  �� ��,E�O�kv b �� =���� f g���� 0 execute_action  �� �� h��  h  ������ 0 nm  �� 0 ctx  ��   f �������� 0 nm  �� 0 ctx  �� 0 txt   g 	 ]���� U����������
�� .miscactvnull��� ��� null�� 0 ACT_PATH  
�� 
strq
�� 
kfil
�� 
cwin
�� 
tcnt
�� .coredoscnull��� ��� ctxt�� %� *j O��,E�O��,%�*�k/�,l UOkascr  ��ޭ