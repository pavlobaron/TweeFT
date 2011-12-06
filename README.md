TweeFT - Twitter based File Transfer

With TweeFT one can use Twitter's direct messages to transfer files.

Of course, it's asynchronous and slow, and you have to struggle against such things like
character and rate limits. What TweeFT does to overcome some of these these limits is to
use multiple accounts on both ends, sender and receiver. And it's a nice experiment :)

The sender and the receiver accounts must be friends and thus be able to send each other
direct messages. Furthermore, one needs some "worker" accounts which will participate
in file transfer. These worker accounts shouldn't protect their tweets since TweeFT
directly and automatically creates friendships without any "third" media like email.

In the handshake phase, the sender tells the receiver that it wants to send a file with a
given name and a unique key it uses for transfer. The receiver tells the sender a unique
key it uses for the transfer. Then, in several DMs. the receiver tells the sender the names
of all his worker accounts. The sender creates friendships from all his worker accounts with
all worker accounts of the receiver. Then, the sender, in several DMs, sends to the receiver
all names of its worker accounts. The receiver creates friendships from his own worker accounts
with all sender's worker accounts. Of course, if friendships on both ends are already existing,
they will not be touched anyhow. After all that, the handshake is done. We are ready to transfer
the file.

In the transfer phase, the sender cuts up the file into a reasonable number of chunks. This
is done based upon the nuber of worker accounts (sender and receiver), Twitter limits (140
characters per tweet) and packet header and Base64 encoding overhead. Packet header contains
information such as unique transfer key and chunk number. The sender sends to the receiver a
DM containing the overall number of chunks it will get and starts sending the chunks to the
receiver's worker accounts from his own worker accounts. Depending on the size of the file,
the transfer could take weeks or might even never finish :)

Again, it is important to understand that each side uses its own unique key which the other
side marks every DM with so multiple transfers from and to different senders nd receiver can
be easily distinguished. 

After the sender has sent the last chunk, he sends to the receiver the final DM telling he's
done. Now, the receiver only needs to wait until he gets the final chunk in some worker
account's DM. Then, the receiver sends to the sender an acknowledgement that it has received
the whole file.

In case of errors or timeouts, each side (sender and receiver) will send cancelation DMs. TweeFT
will also have to deal with Twiiter limits for maximum tweets per hour per account, so some caps
will need to be done sometimes.

Then, there is of course the integeration. The question is if it would be possible to seamlessly integrate TweeFT into the network stack so we could use a simple FTP client. The first step on the way there will be the inets integration.

That's it.
