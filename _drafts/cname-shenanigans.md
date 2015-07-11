---
title: Trouble with CNAME's
author: Justus
---

For a month or so I've now had the 'justus.science' domain on which this homepage can be found. Sort of around the same time I moved over from [uberspace](https://uberspace.de) to [GitHub Pages](https://pages.github.com) as host and from [Drupal](https://drupal.org) to the (much) more lightweight [Jekyll](http://jekyllrb.com) for infrastructure.

In order to add a custom domain to a github page one has to add a CNAME file to the repository and configure the appropriate DNS entry with the provider. I, as per usual, read the manual quickly and loosely and as a result thought the DNS entry **had** be a CNAME, a belief which was reinforced by the fact that the a file called CNAME had to be put into the repository. So I put a CNAME file into the repository and added the CNAME entry with united domains, the domain resolved and the address bar in the browser was showing the right thing, everything seemed right with the world.

Then I tried to set up email with the new domain, as I had done with the other domain before. Set an MX entry to uberspace. It didn't work. I sent a few test mails, none of them arrived. They bounced in the mail ether for three days and were eventually dropped. I changed the entry and redirected to gmail instead, that seemed to work for some strange reason[^gmail].

[^gmail]:
    Knowing what I know now it might be that I am not remembering the timeline correctly and it might be I had the email redirect **before** I set the CNAME entry for the site and changed it to an MX later, that would make more sense at least.

I could'n figure out what was causing the issue, so I decided it probably was the mailserver that for some reason could not deal with the new domain ending, a claim that, as I realize now, was pretty stupid and then decided to leave it for now, since I wasn't particularly  dependent on the mail addresses.

That could have been the end of it, but a couple of days ago I decided it was time to pick up the issue and finally get it fixed. So I contacted the uberspace support and told them the server was not receiving my mails and I told them what I thought the reason was. They then explained to me what the actual problem was.

Turns out setting a CNAME entry for a domain pretty much overrides everything. CNAME's are designed to redirect all traffic to a (sub)domain to another domain, including email. When A CNAME has been set the DNS server will ignore refuse any other entry for that same name and by setting one for 'justus.science' I inadvertently directed all emails going to *@justus.science* to GitHub, which does not provide an email service and was simply dropping the them.

the fix was rather simple. A second look at the GitHub pages revealed any type of DNS entry could be used for a page (and why shouldn't it). So I just changed the CNAME to an A entry[^aentry] to [GitHub's IP][githubaname], wait for the TTL to expire, send test mails again and suddenly they all arrived as expected and instantly. The MX entry was now in effect.

[githubaname]: https://help.github.com/articles/tips-for-configuring-an-a-record-with-your-dns-provider/

[^aentry]:
    If you'd like to know more about setting A names with GitHub, [here][githubaname] is the official help page.
