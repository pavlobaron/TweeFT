TweeFT - Twitter based File Transfer

With TweeFT one can use Twitter's direct messages to transfer files.

Of course, it's asynchronous and slow, and you have to struggle against such things like
character and rate limits. What TweeFT does to overcome some of these these limits is to
use multiple accounts on both ends, sender and receiver. And it's a nice experiment :)

The sender and the receiver accounts must be friends and thus be able to send each other
direct messages. Furthermore, one needs those "worker" accounts which will participate
in file transfer.

In the handshake phase, the sender tells the receiver that it wants to send a file with a
given name. The receiver tells the sender a unique key to use for the transfer as well as
the number of his worker accounts. The sender, in a loop, sends to the receiver all names
of its worker accounts. The receiver, in a loop, sends from his own worker accounts
friendship requests to the sender's worker accounts. The sender all these requests or
ignores them if the friendships are already established. The sender knows the overall number
of firendship requests he has to confirm, so he waits until they all are done. Then, the
handshake is done. We are ready to transfer the file.

In the transfer phase, the sender cuts up the file into a reasonable number of chunks. This
is done based upon the nuber of worker accounts (sender and receiver), Twitter limits (140
characters per tweet) and packet header and Base64 encoding overhead. Packet header contains
information such as unique transfer key and chunk number. The sender sends to the receiver a
DM containing the overall number of chunks it will get and starts sending the chunks to the
receiver's worker accounts from his own worker accounts. Depending on the size of the file,
the transfer could take weeks or might even never finish :)

After the sender has sent the last chunk, he sends to the receiver the final DM telling he's
done. Now, the receiver only needs to wait until he gets the final chunk in some worker
account's DM. Then, the receiver sends to the sender an acknowledgement that it has received
the whole file.

In case of errors or timeouts, each side (sender and receiver) will send cancelation DMs.

That's it.