%%   
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{jcmsi}
              [2010/3/30 v1.2
%              [2010/1/06 v1.1
%              [2008/2/04 v1.0
%              [2008/1/16 v1.0
%              [2007/12/22 v1.0
%              [2007/12/11 v1.0
%              [2007/12/08 v1.0
%              [2007/10/18 v1.0
JCMSI class
ALL Rights reserved
Copyright SANBI Co., Ltd. ]




%% Color
\RequirePackage[usenames]{color}      %%%%color



\newif\if@cameraready \@camerareadyfalse
\DeclareOption{cameraready}{\@camerareadytrue}

%%% Proof
\newif\if@Proof \@Prooffalse%
\DeclareOption{Proof}{\@Prooftrue}

\ExecuteOptions{Prooffalse}

%%% 
\ProcessOptions




%%% center
\def\Center{\topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
 \trivlist \centering\item\relax}
\def\endCenter{\endtrivlist}

%%%% parameter %%%%%%%%%
\unitlength=1mm
\predisplaypenalty=0

%%%%%%%%%%%%%%%%%%%%%%%%

%%%  
\def\Hline{\noalign{\hrule height .25mm}}


%%%%%%%%%%%%%%%%% These are borrowed style files %%%%%%%%%%%
%%% from  LaTeX
\def\pushtowall{\relax\leavevmode
\ifmmode\def\next{\mathpalette\mathpushw@ll}
\else\let\next\makepushw@ll \fi \next}
\def\finpushw@ll{\wd0=0pt \box0}
\def\makepushw@ll#1{\setbox0=\hbox{#1}\finpushw@ll}
\def\mathpushw@ll#1#2{\setbox0=\hbox{$\m@th#1{#2}$}\finpushw@ll}
%%%% 

%%%%% from indent.sty
% Newsgroups: comp.text.tex
% From: cameron@symcom.math.uiuc.edu (Cameron Smith)

\newenvironment{indentation}[2]%
{%
  \par
  \setlength{\leftmargin}{#1}%
  \setlength{\rightmargin}{#2}%
  \advance\linewidth -\leftmargin
  \advance\linewidth -\rightmargin
  \advance\@totalleftmargin\leftmargin
  \@setpar{{\@@par}}%
  \parshape 1 \@totalleftmargin \linewidth
  \ignorespaces
}%
{\par}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% These are borrowed style files %%%%%%%%%%
%     C I T E . S T Y
%
%     version 3.8  (Apr 1999)
%
%     Compressed, sorted lists of numerical citations: [11-16]
%     see also OVERCITE.STY and DRFTCITE.STY
%
%     Copyright (C) 1989-1999 by Donald Arseneau
%     These macros may be freely transmitted, reproduced, or modified
%     provided that this notice is left intact.
%
%     Instructions follow \endinput.
%  ------------------------------------
% First, ensure that some catcodes have the expected values
%
\edef\citenum{% to restore funny codes
  \catcode\string`\string ` \the\catcode\string`\`
  \catcode\string`\string ' \the\catcode\string`\'
  \catcode\string`\string = \the\catcode\string`\=
  \catcode\string`\string _ \the\catcode\string`\_
  \catcode\string`\string : \the\catcode\string`\:}
\catcode\string`\`12
\catcode`\'12
\catcode`\=12
\catcode`\_8
\catcode`\:12

%   Handle optional variations:  [verbose,nospace,space,nosort,noadjust],
%   \citeform,\citeleft,\citeright,\citemid,\citepunct,\citedash
%
%   Set defaults:

%   [ on the left.
\@ifundefined{citeleft}{\let\citeleft=[}{}

%   ] on the right:
\@ifundefined{citeright}{\let\citeright=]}{}

%   , (comma space) before note
%\@ifundefined{citemid}{\def\citemid{,\penalty\@medpenalty\ }}{}
\@ifundefined{citemid}{\def\citemid{,\penalty\@medpenalty}}{}

%   , (comma thin-space) between entries; [nospace] eliminates the space
\@ifundefined{citepunct}{
   \def\citepunct{,\penalty\@m\hskip.13emplus.1emminus.1em}%
 }{}

%   -- (endash) designating range of numbers:
% (using \hbox avoids easy \exhyphenpenalty breaks)
\@ifundefined{citedash}{\def\citedash{\hbox{]--[}\penalty\@m }}{}

%   Each number left as-is:
\@ifundefined{citeform}{\def\citeform{}}{}

%   Do not repeat warnings.  [verbose] reverses
\let\oc@verbo\relax

\@ifundefined{DeclareOption}{}%
{ \toks@={\def\oc@verbo#1#2#3#4{}}
  \DeclareOption{verbose}{\the\toks@}
  \DeclareOption{nospace}{\def\citepunct{,\penalty\@m}}
%  \DeclareOption{space}{\def\citepunct{,\penalty\@highpenalty\ }}
  \DeclareOption{space}{\def\citepunct{,\penalty\@highpenalty}}
  \DeclareOption{nosort}{\def\@addto@cite@list
   {\edef\@cite@list{\@cite@list \@celt{\@B@citeB}}}}
  \DeclareOption{sort}{\let\@cite@list\relax}% default!
  \DeclareOption{noadjust}{\let\cite@adjust\@empty}% Don't change spaces
  \DeclareOption{adjust}{\let\cite@adjust\relax}% adjust space before [ ]
%  \ProvidesPackage{cite}[1999/04/23 \space  v 3.8]
  \ProcessOptions }

%----------------------
% \citen uses \@nocite to ignore spaces after commas, and write the aux file
% \citation. \citen then loops over the citation tags, using \@make@cite@list
% to make a sorted list of numbers.  Finally, \citen executes \@citelist to
% compress ranges of numbers and print the list. \citen can be used by itself
% to give citation numbers without the brackets and other formatting; e.g.,
% "See also ref.~\citen{junk}."
%
\edef\citen{\noexpand\protect \expandafter\noexpand\csname citen \endcsname}

\@namedef{citen }#1{%
\begingroup
\let\@safe@activesfalse\@empty
\@nocite{#1}% ignores spaces, writes to .aux file, returns #1 in \@no@sparg
\@tempcntb\m@ne    % \@tempcntb tracks highest number
\let\@h@ld\relax   % nothing held from list yet
\let\@citea\@empty % no punctuation preceding first
\let\@celt\delimiter % an unexpandable, but identifiable, token
\def\@cite@list{}% % empty list to start
\@for \@citeb:=\@no@sparg\do{\@make@cite@list}% make a sorted list of numbers
% After sorted citelist is made, execute it to compress citation ranges.
\@tempcnta\m@ne    % no previous number
\let\@celt\@compress@cite \@cite@list % output number list with compression
\@h@ld % output anything held over
\endgroup}

% For each citation, check if it is defined and if it is a number.
% if a number: insert it in the sorted \@cite@list
% otherwise: output it immediately.
%
\def\@make@cite@list{%
 \expandafter\let \expandafter\@B@citeB
          \csname b@\@citeb\@extra@b@citeb \endcsname
 \ifx\@B@citeB\relax % undefined: output ? and warning
    \@citea {\bf{?}}\let\@citea\citepunct \G@refundefinedtrue
    \@warning {Citation `\@citeb' on page \thepage\space undefined}%
    \oc@verbo \global\@namedef{b@\@citeb\@extra@b@citeb}{?}%
 \else %  defined               % remove previous line to repeat warnings
    \ifcat _\ifnum\z@<0\@B@citeB _\else A\fi % a positive number, put in list
       \@addto@cite@list
    \else % citation is not a number, output immediately
       \@citea \citeform{\@B@citeB}%
       \let\@citea\citepunct
 \fi\fi}

% Regular definition for adding entry to cite list, with sorting

\@ifundefined{@addto@cite@list}{% sort option either declared or defaulted
  \def\@addto@cite@list{\@tempcnta\@B@citeB \relax
     \ifnum \@tempcnta>\@tempcntb % new highest, add to end (efficiently)
        \edef\@cite@list{\@cite@list \@celt{\@B@citeB}}%
        \@tempcntb\@tempcnta
     \else % arbitrary number: insert appropriately
        \edef\@cite@list{\expandafter\@sort@celt \@cite@list \@gobble @}%
     \fi}
%
% \@sort@celt inserts number (\@tempcnta) into list of \@celt{num} (#1{#2})
% \@celt must not be expandable; list should end with two vanishing tokens.
%
  \def\@sort@celt#1#2{\ifx \@celt #1% parameters are \@celt {num}
       \ifnum #2<\@tempcnta % number goes later in list
          \@celt{#2}%
          \expandafter\expandafter\expandafter\@sort@celt % continue
       \else % number goes here
          \@celt{\number\@tempcnta}\@celt{#2}% stop comparing
    \fi\fi}
}% end sort option definitions
{}% nosort definition is done in options processing

% Check if each number follows previous and can be put in a range
%
\def\@compress@cite#1{%  % This is executed for each number
  \advance\@tempcnta\@ne % Now \@tempcnta is one more than the previous number
  \ifnum #1=\@tempcnta   % Number follows previous--hold on to it
     \ifx\@h@ld\relax    % first pair of successives
        \edef\@h@ld{\@citea \noexpand\citeform{#1}}%
     \else               % compressible list of successives
        \def\@h@ld{\citedash \citeform{#1}}%
     \fi
  \else   %  non-successor -- dump what's held and do this one
     \@h@ld \@citea \citeform{#1}\let\@h@ld\relax
  \fi \@tempcnta#1\let\@citea\citepunct
}

\edef\cite{\noexpand\protect\expandafter\noexpand\csname cite \endcsname}

\@namedef{cite }{\@ifnextchar [{\@tempswatrue\@citex}{\@tempswafalse\@citex[]}}

%  Make \@citex refer to \citen:
%
\def\@citex[#1]#2{\@cite{\citen{#2}}{#1}}%

%  Replacement for \@cite which defines the formatting normally done
%  around the citation list.  Minor changes can
%  be done by changing \citeleft, \citemid, and \citeright; but in other
%  cases it might be necessary to redefine the whole macro.
%
\def\@cite#1#2{\leavevmode \cite@adjust
  \citeleft{#1\if@tempswa \citemid #2\fi
  \spacefactor\@m % punctuation in note doesn't affect outside
  }\citeright}

%  Put a penalty before the citation, and adjust the spacing: if no space
%  already or if there is extra space due to some punctuation, then change
%  to one inter-word space.
%
\@ifundefined{cite@adjust}{\def\cite@adjust{%
  \@tempskipa\lastskip \edef\@tempa{\the\@tempskipa}\unskip
  \ifnum\lastpenalty=\z@ \penalty\@highpenalty \fi
  \ifx\@tempa\@zero@skip \spacefactor1001 \fi % if no space before, set flag
%  \ifnum\spacefactor>\@m \ \else \hskip\@tempskipa \fi}}{}
  \ifnum\spacefactor>\@m \else \hskip\@tempskipa \fi}}{}

\edef\@zero@skip{\the\z@skip}

% \nocite: This is changed to ignore *ALL* spaces and be robust.  The
% parameter list, with spaces removed, is `returned' in \@no@sparg, which
% is used by \citen.
%
\edef\nocite{\noexpand\protect\expandafter\noexpand\csname nocite \endcsname}

\@namedef{nocite }#1{\@bsphack \@nocite{#1}%
 \@for \@citeb:=\@no@sparg\do{\@ifundefined{b@\@citeb\@extra@b@citeb}%
    {\G@refundefinedtrue\@warning{Citation `\@citeb' undefined}%
    \oc@verbo \global\@namedef{b@\@citeb\@extra@b@citeb}{?}}{}}%
 \@esphack}

\def\@nocite#1{\xdef\@no@sparg{\@ignsp#1 \! }% remove *ALL* spaces
 \if@filesw \immediate\write\@auxout {\string\citation {\@no@sparg}}\fi}

% for ignoring *ALL* spaces in the input.  This presumes there are no
% \outer tokens and no \if-\fi constructs in the parameter.  Spaces inside
% braces are retained.
%
\def\@ignsp#1 {\ifx\!#1\@empty\else #1\expandafter\@ignsp\fi}

\let\nocitecount\relax  % in case \nocitecount was used for drftcite

\@ifundefined{@extra@b@citeb}{\def\@extra@b@citeb{}}{}
%  in case no fancy bib package (chapterbib) defines this

\@ifundefined{G@refundefinedtrue}{\let\G@refundefinedtrue\relax}{}

\citenum % execute restore-catcodes

% Aliases:
\let\citenum\citen
\let\citeonline\citen

\renewcommand\citepunct{],[}
%%% \endinput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%




\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagefalse
\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\fi
\if@compatibility
  \renewcommand\@ptsize{0}
\else
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\ExecuteOptions{a4paper,twoside,twocolumn,final}
\ProcessOptions

%%% bk10.clo  \input{size1\@ptsize.clo}
%\ProvidesFile{bk10.clo}
%              [2000/05/19 v1.4b
%      Standard LaTeX file (size option)]






%OT1cmr
\DeclareFontShape{OT1}{cmr}{m}{n}%
     {<-5.5>   cmr5%
      <5.5-6.5>   cmr6%
      <6.5-7.5>   cmr7% 
      <7.5-8.5>   cmr8%
      <8.5-11.5>  cmr10%
      <11.5-16.5> cmr12%
      <16.5->   cmr17%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{sl}%
     {  <-8.5>   cmsl8%
      <8.5-9.5>  cmsl9%
      <9.5-11.5> cmsl10%
      <11.5->    cmsl12%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{it}%
     {%
      <-7.5>     cmti7%
      <7.5-8.5>  cmti8%
      <8.5-9.5>  cmti9%
      <9.5-11.5> cmti10%
      <11.5->    cmti12%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{sc}%
     {%
      <->cmcsc10%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{ui}
     {%
      <-> cmu10%
      }{}
%%%%%%% bold series
\DeclareFontShape{OT1}{cmr}{b}{n}
     {%
      <-> cmb10%
      }{}
%%%%%%%% bold extended series
\DeclareFontShape{OT1}{cmr}{bx}{n}
   {%
      <-5.5>     cmbx5
      <5.5-6.5>  cmbx6
      <6.5-7.5>  cmbx7
      <7.5-8.5>  cmbx8
      <8.5-9.5>  cmbx9%
      <9.5-11.5> cmbx10%
      <11.5->    cmbx12%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{sl}
      {%
      <-> cmbxsl10%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{it}
      {%
      <-> cmbxti10%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{ui}
      {<->sub*cmr/m/ui}{}
%OMScmsy
\DeclareFontShape{OMS}{cmsy}{m}{n}{%
      <-5.5>    cmsy5
      <5.5-6.5> cmsy6
      <6.5-7.5> cmsy7
      <7.5-8.5> cmsy8
      <8.5-9.5> cmsy9
      <9.5->    cmsy10%
      }{}
\DeclareFontShape{OMS}{cmsy}{b}{n}{%
      <   -5.5> cmbsy5
      <5.5-6.5> cmbsy6
      <6.5-7.5> cmbsy7
      <7.5-8.5> cmbsy8
      <8.5-9.5> cmbsy9
      <9.5-   > cmbsy10%
      }{}
%OMXcmex
\DeclareFontShape{OMX}{cmex}{m}{n}{%
   <-> cmex10%
   }{}
%OMLcmmi
\DeclareFontShape{OML}{cmm}{m}{it}%
     {<   -5.5>    cmmi5
      <5.5-6.5> cmmi6
      <6.5-7.5> cmmi7
      <7.5-8.5> cmmi8
      <8.5-9.5> cmmi9%
      <9.5-11.5>cmmi10%
      <11.5-   >cmmi12%
      }{}
\DeclareFontShape{OML}{cmm}{b}{it}{%
      <   -5.5>    cmmib5
      <5.5-6.5> cmmib6
      <6.5-7.5> cmmib7
      <7.5-8.5> cmmib8
      <8.5-9.5> cmmib9%
      <9.5->    cmmib10%
      }{}
\DeclareFontShape{OML}{cmm}{bx}{it}%
   {<->ssub*cmm/b/it}{}
%%OT1cmtt
\DeclareFontShape{OT1}{cmtt}{m}{n}
     {%
      <   -8.5>     cmtt8
      <8.5-9.5>  cmtt9%
      <9.5-11.5> cmtt10%
      <11.5-   >    cmtt12%
      }{}
%%%%%% make sure subst shapes are available
\DeclareFontShape{OT1}{cmtt}{m}{it}
     {%
      <-> cmitt10%
      }{}
\DeclareFontShape{OT1}{cmtt}{m}{sl}
     {%
      <-> cmsltt10%
      }{}
\DeclareFontShape{OT1}{cmtt}{m}{sc}
     {%
      <-> cmtcsc10%
      }{}
\DeclareFontShape{OT1}{cmtt}{m}{ui}
  {<->ssub*cmtt/m/it}{}
\DeclareFontShape{OT1}{cmtt}{bx}{n}
  {<->ssub*cmtt/m/n}{}
\DeclareFontShape{OT1}{cmtt}{bx}{it}
  {<->ssub*cmtt/m/it}{}
\DeclareFontShape{OT1}{cmtt}{bx}{ui}
  {<->ssub*cmtt/m/it}{}
%%\changes{v0.3}{2002/09/11}{amsfonts}
%umsa
\DeclareFontFamily{U}{msa}{}
\DeclareFontShape{U}{msa}{m}{n}{
  <   -5.5> msam5
  <5.5-6.5> msam6
  <6.5-7.5> msam7
  <7.5-8.5> msam8
  <8.5-9.5> msam9
  <9.5-    > msam10
  }{}
\DeclareFontFamily{U}{msb}{}
\DeclareFontShape{U}{msb}{m}{n}{
  <   -5.5> msbm5
  <5.5-6.5> msbm6
  <6.5-7.5> msbm7
  <7.5-8.5> msbm8
  <8.5-9.5> msbm9
  <9.5-   > msbm10
  }{}
%%for latexsym
\DeclareFontFamily{U}{lasy}{}
\DeclareFontShape{U}{lasy}{m}{n}{
 <   -5.5>lasy5
 <5.5-6.5>lasy6
 <6.5-7.5>lasy7
 <7.5-8.5>lasy8
 <8.5-9.5>lasy9
 <9.5-    >lasy10  }{}
\DeclareFontShape{U}{lasy}{b}{n}{ 
     <  -10> ssub * lasy/m/n
     <10-  > lasyb10  }{}
%%%



\newdimen\JQ
 \JQ=0.7392507pt
\newdimen\Q
 \Q=0.7392507pt%0.71144pt
\newdimen\EM
 \EM=.03125em
\newdimen\h
\h=0.25mm

\newdimen\EQ
 \EQ=1.1\Q



\def\Cvs{\baselineskip}%%%% 


 \def\@vpt{5}
 \def\@vipt{6}
 \def\@viipt{7}
 \def\@viiipt{8}
 \def\@ixpt{9}
 \def\@xpt{10}
 \def\@xipt{10.95}
 \def\@xiipt{12}
 \def\@xivpt{14.4}
 \def\@xviipt{17.28}
 \def\@xxpt{20.74}
 \def\@xxvpt{24.88}


%\renewcommand\normalsize{%
%   \@setfontsize\normalsize\@xpt\@xiipt
%   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
%   \abovedisplayshortskip \z@ \@plus3\p@
%   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
%   \belowdisplayskip \abovedisplayskip
%   \let\@listi\@listI}
%\normalsize

\renewcommand\normalsize{%
%   \@setfontsize\normalsize\@xpt{17\Q}%
   \@setfontsize\normalsize{13\Q}{17\h}%
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize

\newcommand\small{%
   \@setfontsize\small{12\Q}{15\h}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 4\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\footnotesize{%
   \@setfontsize\footnotesize{11\Q}{15\h}%
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\scriptsize{\@setfontsize\scriptsize{10\Q}{14\h}}
\newcommand\tiny{\@setfontsize\tiny{7\Q}{11\h}}
\newcommand\large{\@setfontsize\large{14\Q}{18\h}}
%%\newcommand\large{\@setfontsize\large\@xiipt{14}}
\newcommand\Large{\@setfontsize\Large{16\Q}{20\h}}
\newcommand\LARGE{\@setfontsize\LARGE{20\Q}{24\h}}
\newcommand\XXIQ{\@setfontsize\XXIQ{21\Q}{24\h}}
\newcommand\huge{\@setfontsize\huge\@xxpt{25}}
\newcommand\Huge{\@setfontsize\Huge\@xxvpt{30}}
\if@twocolumn
  \setlength\parindent{1em}
\else
  \setlength\parindent{15\p@}
\fi
\setlength\smallskipamount{3\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\medskipamount{6\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\bigskipamount{12\p@ \@plus 4\p@ \@minus 4\p@}
\setlength\headheight{12\p@}
\setlength\headsep   {17.5\Q}
\setlength\topskip   {13\Q}%{10\p@}
\setlength\footskip{27.5\Q}%{17.5\Q}%{.35in}
\if@compatibility \setlength\maxdepth{4\p@} \else
\setlength\maxdepth{.5\topskip} \fi
\if@compatibility
  \if@twocolumn
    \setlength\textwidth{410\p@}
  \else
    \setlength\textwidth{4.5in}
  \fi
\else
  \setlength\@tempdima{\paperwidth}
  \addtolength\@tempdima{-2in}
  \setlength\@tempdimb{345\p@}
  \if@twocolumn
    \ifdim\@tempdima>2\@tempdimb\relax
      \setlength\textwidth{2\@tempdimb}
    \else
      \setlength\textwidth{\@tempdima}
    \fi
  \else
    \ifdim\@tempdima>\@tempdimb\relax
      \setlength\textwidth{\@tempdimb}
    \else
      \setlength\textwidth{\@tempdima}
    \fi
  \fi
\fi
\if@compatibility\else
  \@settopoint\textwidth
\fi
\if@compatibility
  \setlength\textheight{41\baselineskip}
\else
  \setlength\@tempdima{\paperheight}
  \addtolength\@tempdima{-2in}
  \addtolength\@tempdima{-1.5in}
  \divide\@tempdima\baselineskip
  \@tempcnta=\@tempdima
  \setlength\textheight{\@tempcnta\baselineskip}
\fi
\addtolength\textheight{\topskip}
\if@twocolumn
 \setlength\marginparsep {10\p@}
\else
  \setlength\marginparsep{7\p@}
\fi
\setlength\marginparpush{5\p@}
\if@compatibility
   \setlength\oddsidemargin   {.5in}
   \setlength\evensidemargin  {1.5in}
   \setlength\marginparwidth {.75in}
  \if@twocolumn
     \setlength\oddsidemargin  {30\p@}
     \setlength\evensidemargin {30\p@}
     \setlength\marginparwidth {48\p@}
  \fi
\else
  \if@twoside
    \setlength\@tempdima        {\paperwidth}
    \addtolength\@tempdima      {-\textwidth}
    \setlength\oddsidemargin    {.4\@tempdima}
    \addtolength\oddsidemargin  {-1in}
    \setlength\marginparwidth   {.6\@tempdima}
    \addtolength\marginparwidth {-\marginparsep}
    \addtolength\marginparwidth {-0.4in}
  \else
    \setlength\@tempdima        {\paperwidth}
    \addtolength\@tempdima      {-\textwidth}
    \setlength\oddsidemargin    {.5\@tempdima}
    \addtolength\oddsidemargin  {-1in}
    \setlength\marginparwidth   {.5\@tempdima}
    \addtolength\marginparwidth {-\marginparsep}
    \addtolength\marginparwidth {-0.4in}
    \addtolength\marginparwidth {-.4in}
  \fi
  \ifdim \marginparwidth >2in
     \setlength\marginparwidth{2in}
  \fi
  \@settopoint\oddsidemargin
  \@settopoint\marginparwidth
  \setlength\evensidemargin  {\paperwidth}
  \addtolength\evensidemargin{-2in}
  \addtolength\evensidemargin{-\textwidth}
  \addtolength\evensidemargin{-\oddsidemargin}
  \@settopoint\evensidemargin
\fi
\if@compatibility
  \setlength\topmargin{.75in}
\else
  \setlength\topmargin{\paperheight}
  \addtolength\topmargin{-2in}
  \addtolength\topmargin{-\headheight}
  \addtolength\topmargin{-\headsep}
  \addtolength\topmargin{-\textheight}
  \addtolength\topmargin{-\footskip}     % this might be wrong!
  \addtolength\topmargin{-.5\topmargin}
  \@settopoint\topmargin
\fi
\setlength\footnotesep{6.65\p@}
\setlength{\skip\footins}{9\p@ \@plus 4\p@ \@minus 2\p@}
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}





\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\setlength\partopsep{2\p@ \@plus 1\p@ \@minus 1\p@}
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@ \@plus2\p@ \@minus\p@
            \topsep 8\p@ \@plus2\p@ \@minus4\p@
            \itemsep4\p@ \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    4\p@ \@plus2\p@ \@minus\p@
              \parsep    2\p@ \@plus\p@  \@minus\p@
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    2\p@ \@plus\p@\@minus\p@
              \parsep    \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep   \topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
%%%%\endinput
%%
%%%%%%%%%%%%%%%%%%5 End of file `bk10.clo'.



\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
%\setlength\parskip{0\p@ \@plus \p@}
\setlength\parskip{\z@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301


\setcounter{topnumber}{5}
\setcounter{bottomnumber}{5}
\setcounter{totalnumber}{10}
\setcounter{dbltopnumber}{5}
\renewcommand{\topfraction}{.95}
\renewcommand{\bottomfraction}{.95}
\renewcommand{\textfraction}{.05}
\renewcommand{\floatpagefraction}{.05}
\renewcommand{\dbltopfraction}{.95}
\renewcommand{\dblfloatpagefraction}{.05}





\if@Proof
 \def\@Rtop{\rlap{\smash{\rule[-\headsep]{0.05mm}{10mm}%
  \rule[-\headsep]{10mm}{0.05mm}}}}
 \def\@Ltop{\llap{\smash{\rule[-\headsep]{10mm}{0.05mm}%
  \rule[-\headsep]{0.05mm}{10mm}}}}
 \def\@Rbot{\rlap{\smash{\raisebox{1\footskip}
  {\rule[-10mm]{0.05mm}{10mm}\rule{10mm}{0.05mm}}}}}
 \def\@Lbot{\llap{\smash{%
%\pushtowall{\usebox{\daisibox}}%
\raisebox{1\footskip}
  {\rule{10mm}{0.05mm}\rule[-10mm]{0.05mm}{10mm}}}}}
%%%%
 \def\@Ctate{\relax}
\def\@Cyoko{\relax}
%%%
 \def\pot@jobname{\smash{\raise7mm\rlap{\LARGE\texttt{\jobname}}}}
\else
 \let\@Rtop\relax\let\@Ltop\relax\let\@Rbot\relax\let\@Lbot\relax\let\@Ctate\relax\let\@Cyoko\relax
 \let\pot@jobname\relax
\fi















%%% These macros are borrowed from
%%%   sice.cls (pLaTeX2e)
%%   for Transactions of the Society of Instrument and Control Engineers
%%    by Motoaki Sato (ULS and Company), 2006. 
%%     
%%

\def\specialissue#1{%
 \gdef\@specialissue{%
  \vtop{\hrule \@height.1mm
   \hbox{%
    \vrule \@width.1mm \@height 6mm
    \vbox to 6mm{\vss
     \hbox{\hskip1.5mm SPECIAL Xxxxxx\hskip3mm #1\hskip1.5mm\null}%
    \vss}%
    \vrule \@width.1mm \@height 6mm
   }%
   \hrule \@height.1mm
  }\global\@tempdimc-1mm}}
\def\@specialissue{}

\newdimen\@tempdimc



\def\make@titlehead{%
 \@tempdimc1mm
 \leavevmode
 \hbox to \hsize{%
    \raise4.75mm\hbox{%
%   \raise1.75mm\hbox{%
    \vtop{\hbox{\@specialissue}\vskip-\@tempdimc
     \hbox{%
      \vbox to 7mm{\hsize=1.5mm
       \hrule \@width 1.5mm \@height .2mm
       \vss
       \hbox to 1.5mm{\vrule \@width .2mm \@height 7mm\hss}%
       \vss
       \hrule \@width 1.5mm \@height .2mm
      }\hskip2mm%
       \raisebox{0mm}{\vbox{%\raisebox{1mm}{%
        \hbox to 40mm{\hfill\scriptsize\bfseries
         SICE Journal of Control,\hfill}% 48.5mm
         \vskip-.9mm
        \hbox to 40mm{\scriptsize\bfseries\hss Measurement, and System Integration\hss}%
         \vskip-1.55mm
        \hbox to 40mm{\fontsize{9\Q}{12\Q}\selectfont%\tiny
\hss Vol.\,\@VolForHeadings, No.\,\@InputNo, 
%          pp.\,\thepage--\pageref{sice@lastpage}, \fmt@month{\@No} \@Year\hss}%
          pp.\,\ifnum\thepage<100 00\thepage\else\ifnum\thepage<10 0\thepage\else\thepage\fi\fi--\ifnum\thepage<100 00\pageref{sice@lastpage}\else\ifnum\pageref{sice@lastpage}<10 0\pageref{sice@lastpage}\else\thepage\fi\fi, \fmt@month{\@Month} \@Year\hss}%
       }}\hskip2mm%
      \vbox to 7mm{\hsize=1.5mm
       \hrule \@width1.5mm \@height .2mm
       \vss
       \hbox to 1.5mm{\hss\vrule \@width .2mm \@height 7mm}%
       \vss
       \hrule \@width1.5mm \@height .2mm
      }%
     }%
    }}}}%







\def\make@titlehead{%
 \@tempdimc1mm
 \leavevmode
 \hbox to \hsize{%
    \raise4.75mm\hbox{%
    \vtop{\hbox{\@specialissue}\vskip-\@tempdimc
     \hbox{%
%      \vbox to 7mm{\hsize=1.5mm
%       \hrule \@width 1.5mm \@height .2mm
%       \vss
%       \hbox to 1.5mm{\vrule \@width .2mm \@height 7mm\hss}%
%       \vss
%       \hrule \@width 1.5mm \@height .2mm
%      }\hskip2mm%
       \raisebox{1mm}{\vbox{%\raisebox{1mm}{%
        \ifodd\thepage \else\hfill\fi{\scriptsize\bfseries
         SICE Journal of Control,  Measurement, and System Integration }
        {\fontsize{9\Q}{12\Q}\selectfont%\tiny
 Vol.\,\@VolForHeadings, No.\,\@InputNo, 
          pp.\,\ifnum\thepage<100 00\thepage\else\ifnum\thepage<10 0\thepage\else\thepage\fi\fi--\ifnum\thepage<100 00\pageref{sice@lastpage}\else\ifnum\pageref{sice@lastpage}<10 0\pageref{sice@lastpage}\else\thepage\fi\fi, \fmt@month{\@Month} \@Year}%
       }}%\hskip2mm%
%      \vbox to 7mm{\hsize=1.5mm
%       \hrule \@width1.5mm \@height .2mm
%       \vss
%       \hbox to 1.5mm{\hss\vrule \@width .2mm \@height 7mm}%
%       \vss
%       \hrule \@width1.5mm \@height .2mm
%      }%
     }%
    }}}}%







\def\make@titlehead{%
 \@tempdimc1mm
 \leavevmode
 \hbox to \hsize{%
    \raise4.75mm\hbox{%
    \vtop{\hbox{\@specialissue}\vskip-\@tempdimc
     \hbox{%
       \raisebox{1mm}{\vbox{%\raisebox{1mm}{%
        \ifodd\thepage \else\hfill\fi{\scriptsize\bfseries
         SICE Journal of Control,  Measurement, and System Integration }
        {\fontsize{9\Q}{12\Q}\selectfont%\tiny
 Vol.\,\@VolForHeadings, No.\,\@InputNo, 
%
          pp.\,
\ifnum\thepage<10 00\thepage\else
\ifnum\thepage<100 0\thepage\else
%\ifnum\thepage<1000 0\thepage\else
\thepage%
\fi\fi%\fi
--%
\pageref{sice@lastpage}, \fmt@month{\@Month} \@Year
}%
       }}%\hskip2mm%
     }%
    }}}}%








\def\make@titlehead{%
 \@tempdimc1mm
 \leavevmode
 \hbox to \hsize{%
    \raise4.75mm\hbox{%
    \vtop{\hbox{\@specialissue}\vskip-\@tempdimc
     \hbox{%
       \raisebox{1mm}{\vbox{%\raisebox{1mm}{%
        \ifodd\thepage \else\hfill\fi{\scriptsize\sf
         SICE Journal of Control,  Measurement, and System Integration, %}
%        {\fontsize{9\Q}{12\Q}\selectfont%\tiny
 Vol.\,\@VolForHeadings, No.\,\@InputNo, 
%
          pp.\,
\ifnum\thepage<10 00\thepage\else
\ifnum\thepage<100 0\thepage\else
%\ifnum\thepage<1000 0\thepage\else
\thepage%
\fi\fi%\fi
--%
\pageref{sice@lastpage}, \fmt@month{\@Month} \@Year
}%
       }}%\hskip2mm%
     }%
    }}}}%






















\def\Year#1{%
 \gdef\@Year{#1}%
 \afterassignment\remove@to@nnil
  \count@ 0#1\relax\@nnil
 \ifnum\count@=\z@
  \gdef\@Year{2006}%
 \else
  \@tempcnta=#1\relax
  \advance \@tempcnta -2000\relax
  \xdef\@@Year{0\the\@tempcnta}%
 \fi
}
\def\@Year{}
\def\@@Year{}



\def\Vol#1{%
 \gdef\@Vol{%
\ifnum#1 <10 0#1\else%
\ifnum#1 <100 #1\else%
#1\fi\fi
}%
 \gdef\@VolForHeadings{#1}%
 \ifx\@Vol\empty\gdef\@Vol{XX}\fi
 \ifx\@Vol\empty\gdef\@VolForHeadings{XX}\fi
}
\def\@Vol{}
\def\@VolForHeadings{}







\def\No#1{%
 \gdef\@No{#1}%
 \afterassignment\remove@to@nnil
  \count@ 0#1\relax\@nnil
 \ifnum\count@=\z@
  \gdef\@No{0}
 \fi
 \gdef\@@No{\two@digits{\@No}}%
}
\def\@No{}
\def\@@No{}




\renewcommand{\No}[1]{%\setcounter{theArNumcnt}{0}
\def\@tempNoNum{#1}%
\ifx\@tempNoNum\empty \gdef\@No{??}%
\else%
\gdef\@InputNo{#1}%
\gdef\@No{%
\ifnum#1 <10 00#1\else%
\ifnum#1 <100 0#1\else%
#1\fi\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\gdef\@@No{%
\ifnum#1 <10 000#1\else%
\ifnum#1 <100 00#1\else%
#1\fi\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% for headings 
\gdef\@NoForHeadings{%
\ifnum#1 <10 #1\else%
\ifnum#1 <100 #1\else%
#1\fi\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\fi
}




\renewcommand{\No}[1]{%\setcounter{theArNumcnt}{0}
\def\@tempNoNum{#1}%
\ifx\@tempNoNum\empty \gdef\@No{??}%
\else%
\gdef\@InputNo{#1}%
\gdef\@No{%
\ifnum#1 <10 0#1\else%
\ifnum#1 <100 #1\else%
#1\fi\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\gdef\@@No{%
\ifnum#1 <10 000#1\else%
\ifnum#1 <100 00#1\else%
#1\fi\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% for headings 
\gdef\@NoForHeadings{%
\ifnum#1 <10 #1\else%
\ifnum#1 <100 #1\else%
#1\fi\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\fi
}







\def\Month#1{%
 \gdef\@Month{#1}%
 \afterassignment\remove@to@nnil
  \count@ 0#1\relax\@nnil
 \ifnum\count@=\z@
  \gdef\@Month{0}
 \fi
 \gdef\@@Month{\two@digits{\@Month}}%
}
\def\@Month{}
\def\@@Month{}





\def\fmt@month#1{%
 \ifx\tmp@month\empty XXX\else
  \ifcase#1 xxx\or January\or February\or March\or April\or
   May\or June\or July\or August\or September\or October\or
    November\or December\else
   \@ctrerr\fi\relax
 \fi
}


%%%%%   
\def\received#1#2#3{%
 \begingroup
  \def\tmp@month{#1}%
  \protected@xdef\@received{%
   \@received
   \protect\footnotetext[0]{\small%
   \hskip.5em (Received\ 
     \fmt@month{#1}\ 
     #2, #3)}%
  }%
 \endgroup
 \gdef\@receivedyear{#3}}


\def\revised#1#2#3{%
 \begingroup
  \def\tmp@month{#1}%
  \protected@xdef\@revised{%
   \@revised
   \protect\footnotetext[0]{\small%
   \hskip.5em (Revised\ 
     \fmt@month{#1}\ 
     #2, #3)}%
  }%
 \endgroup}

\def\@received{}
\def\@receivedyear{}
\def\@revised{}












%%%%%   
\def\titlenote[#1]#2{%
\rlap{\@textsuperscript{\normalfont\scriptsize%\small
#1}}
\noindent\begingroup
%
%  \def\tmp@month{#1}%
  \protected@xdef\@titlenote{%
%   \@received
\protect\footnotetext[0]{\small%
%   \hskip.5em 
\noindent\leftskip2em%
\noindent\hspace*{-3.45em}\hb@xt@1.8em{\hss$^{#1}$\,}%
%\smash{\protect\pushtowall{\protect\rule{.1mm}{40mm}}}
#2%
}%
  }%
 \endgroup
}

\def\@titlenote{}

\def\@footpage{%
 \ifnum \value{page} < 10\relax
  \gdef\@@footpage{000\thepage}%
 \else
  \ifnum \value{page} < 100\relax
   \gdef\@@footpage{00\thepage}%
  \else
   \ifnum \value{page} < 1000\relax
    \gdef\@@footpage{0\thepage}%
   \else
    \gdef\@@footpage{\thepage}%
   \fi
  \fi
 \fi
}

\def\sice@copyright{\scriptsize \raise.2mm\hbox{\copyright}}
\def\@@receivedyear{%
 \ifx\@receivedyear\empty
  \@Year
 \else
  \@receivedyear
 \fi
}

\Vol{42}
\No{1}
\Year{2006}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@cameraready
 \def\nombre@font{\usefont{T1}{pnc}{b}{it}\footnotesize}
\else
 \def\nombre@font{\footnotesize\bfseries\slshape}
\fi
\def\head@font{\normalfont\small}




\if@twoside
  \def\ps@headings{%
      \def\@evenhead{\@Ltop%
\leavevmode\pushtowall{\hbox to\textwidth{\scriptsize\hfill SICE\hspace{1.25mm}JCMSI,\hspace{2.5mm}Vol.\,\@VolForHeadings,\hspace{2.5mm}No.\,\@NoForHeadings,\hspace{2.5mm}\fmt@month{\@Month}\hspace{2.5mm}\@Year\hfill}}%
\leavevmode\hskip11\Q{\small\slshape{\nombre@font\thepage}}\hfill\@Rtop}%
%      \def\@oddhead{\@Ltop{\slshape\rightmark}\hfil\thepage\@Rtop}%
     \def\@oddhead{\@Ltop%
\leavevmode\pushtowall{\hbox to\textwidth{\scriptsize\hfill
SICE\hspace{1.25mm}JCMSI,\hspace{2.5mm}Vol.\,\@VolForHeadings,\hspace{2.5mm}No.\,\@NoForHeadings,\hspace{2.5mm}\fmt@month{\@Month}\hspace{2.5mm}\@Year\hfill}}%
\hfill{\small\slshape{\nombre@font\thepage}}\hskip11\Q\@Rtop}%
    \def\@evenfoot{\@Lbot\small\hfill\@Rbot}%
    \def\@oddfoot{\@Lbot\small\hfill\@Rbot}%
      \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection\quad
        \fi
        ##1}}{}}%
    \def\subsectionmark##1{%
      \markright {%
        \ifnum \c@secnumdepth >\@ne
          \thesubsection\quad
        \fi
        ##1}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% first page (\maketitle)
\def\ps@sice{%
 \let\@mkboth\@gobbletwo
 \def\@oddhead{\@Ltop\hfil\@Rtop}%
 \let\@evenhead\@oddhead
 \def\@evenfoot{\@Lbot\hfil
  \@footpage{\normalfont\scriptsize
   JCMSI\ 
\count@\@@Year\relax
\ifnum\count@<10\relax
\edef\@@@@Year{0\the\count@}%
\else
\edef\@@@@Year{\the\count@}%
\fi
   \@@No/\@@@@Year/\@Vol\@No--\@@footpage\,\sice@copyright\,\@receivedyear\ 
   SICE}%
  \hfil\@Rbot}%
 \let\@oddfoot\@evenfoot
}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \thesection\quad
        \fi
        ##1}}}}
\fi















\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    }





\def\subtitle#1{\gdef\@subtitle{#1}}
\def\@subtitle{\@latex@error{No \noexpand\subtitle given}\@ehc}

\def\@subtitle{}



%%%% 
%%%% TITLE
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thankssice
%%%
  \let \footnote\affiliate%%%%%%%%%%%%
%%%
  \null\vfil
  \vskip 60\p@
  \begin{center}%
%
    {\XXIQ \@title \par}%
    {\XXIQ \@subtitle \par}%
    \vskip 3em%
    {\Large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\affiliate\relax%%%%%%%
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
%%%
  \global\let\@subtitle\@empty
  \global\let\subtitle\relax
%%%
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
%%%%    ------------ \newcommand\maketitle{\par

\newdimen\MaketitleIntrosep
\MaketitleIntrosep=0mm

\def\maketitle{\@ifnextchar[{\maketitleHIKISU}{\maketitleNO}}



\def\maketitleNO{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote
}%
%%
%%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
%    \thispagestyle{plain}\@thanks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%  affiliate
% \ifx\@affiliate\@undefined\else{%
%    \def\@makefntext{%\parindent1em 
%\noindent\hangindent6mm\hangafter-20}
%    \footnotetext[0]{\@affiliate}%
%  }\fi
%  \global\let\@affiliate\@undefined
%%%%%%%  affiliate 
%
\ifx\@affiliate\@undefined\else{%\leavevmode\noindent%
    \def\@makefntext{\small\leftskip2em%\parindent1em 
\noindent
}
%%%
%%%
\footnotetext[0]{%\leavevmode\noindent
\@affiliate}%
}\fi
  \global\let\@affiliate\@undefined
%
%%%%%%%  end affiliate 
%%%  Email
 \ifx\authors@mail\@undefined\else{%
    \def\@makefntext{\small\leftskip2em%24\Q%2em%\parindent1em 
\noindent}
    \footnotetext[0]{E-mail:\ \authors@mail}%
  }\fi
  \global\let\authors@mail\@undefined
%%
{\small\@received
\@revised}
\@titlenote
 \thispagestyle{sice}
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
%%%%
  \global\let\@subtitle\@empty
  \global\let\subtitle\relax
%%%%
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
 \gdef\@received{}%
 \gdef\@revised{}%
%\setcounter{footnote}{-1}%
}




%%%% \maketitleHIKISU
\def\maketitleHIKISU[#1]{\par
\MaketitleIntrosep#1
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote
}%
%%
%%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
%    \thispagestyle{plain}\@thanks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%  affiliate
% \ifx\@affiliate\@undefined\else{%
%    \def\@makefntext{%\parindent1em 
%\noindent\hangindent6mm\hangafter-20}
%    \footnotetext[0]{\@affiliate}%
%  }\fi
%  \global\let\@affiliate\@undefined
%%%%%%%  affiliate 
\ifx\@affiliate\@undefined\else{\leavevmode\noindent%
    \def\@makefntext{\small\leftskip2em%\parindent1em 
\noindent
}
%%%
%%%
\footnotetext[0]{%\leavevmode\noindent
\@affiliate}%
}\fi
  \global\let\@affiliate\@undefined
%%%%%%%  end affiliate 
%%%  Email
 \ifx\authors@mail\@undefined\else{%
    \def\@makefntext{\small\leftskip2em%24\Q%2em%\parindent1em 
\noindent}
    \footnotetext[0]{E-mail:\ \authors@mail}%
  }\fi
  \global\let\authors@mail\@undefined
%%
{\small\@received
\@revised}
\@titlenote
 \thispagestyle{sice}
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
%%%%
  \global\let\@subtitle\@empty
  \global\let\subtitle\relax
%%%%
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
 \gdef\@received{}%
 \gdef\@revised{}%
%\setcounter{footnote}{-1}%
}

%%%% \maketitleHIKISU









\newbox\@abstractbox
\newbox\@keywordsbox
\newbox\@affiliatebox

\def\abstract{%
 \global\setbox\@abstractbox\hbox\bgroup
  \begin{minipage}[t]{150mm}% 12Q 16H
\small\baselineskip16\h
%\fontsize{\@ixpt}{16\Q}\selectfont%  \if@shortpaper
%   \small
%  \else
%   \normalsize\baselineskip16\@Q
%  \fi
  \parindent1em\noindent{\bfseries Abstract}\,:\ 
  \ignorespaces
}
\def\endabstract{%
%   \unskip\inhibitglue
  \end{minipage}%
 \egroup\ignorespaces}

\def\keywords{%
 \global\setbox\@keywordsbox\hbox\bgroup
  \begin{minipage}[t]{150mm}% 12Q 16H
\small\baselineskip16\h%\fontsize{\@ixpt}{16\Q}\selectfont%  \if@shortpaper
%   \small
%  \else
%   \normalsize\baselineskip16\@Q
%  \fi
%  \@hangfrom
{\bfseries Key Words\,:\ }%
  \kern\z@\ignorespaces
}
\def\endkeywords{%
%   \unskip\inhibitglue
  \end{minipage}%
 \egroup\ignorespaces}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\newbox\author


%%\def\author#1{\gdef\@author{#1}}

%\def\Mauthor#1{\gdef\@Mauthor{#1}\@Mauthor}

\newbox\@Mauthor
%\def\Mauthor#1{\setbox\@Mauthor=\hbox{#1}%
%}





%%%%%%

\def\sice@AUTHOR@sc#1{#1\fontsize{11\Q}{13\h}\selectfont}


\def\fmt@AUTHOR@Ename#1{%
 \bgroup
%  \normalsize\bfseries 
  \def\tr@AUTHOR@name##1 ##2\@nil{##1 \protect\uppercase{\protect\sice@AUTHOR@sc ##2}}%
  \protected@edef\@AUTHORNAME{\expandafter\tr@AUTHOR@name #1\@nil\null}%
  \@AUTHORNAME\ 
 \egroup%
}



\long\def\AUTHORsc#1{%
  \fmt@AUTHOR@Ename{#1}%
}
%%%

%%%%%%







\def\Mauthor#1{\gdef\@Mauthor{#1}}

\newcounter{choshai}
\newcounter{choshaii}


\def\Nakaguro{,\space}
\def\NAkaguro{, and\ }

%\def\NAkaguro{,\ }



\long\def\authorentry#1{%
\setcounter{choshai}{\m@ne}%
\setcounter{choshaii}{\z@}%
\@for\member:=#1\do{\addtocounter{choshai}{\@ne}}%
\@for\member:=#1\do{\addtocounter{choshaii}{\@ne}%
\ifnum\c@choshaii<\c@choshai%
\ifnum\c@choshai<1\relax\expandafter%\J
\member%
\else%
\ifnum\c@choshai<2\relax\member\Nakaguro\ignorespaces%
\else\expandafter%\J
\member\Nakaguro\ignorespaces%
\fi\fi%
\else%
\ifnum\c@choshaii=\c@choshai\expandafter%\J
\member\NAkaguro 
%and%
\else%
\expandafter%\J
\member%
\fi\fi\ignorespaces%
}}



\long\def\authorentry#1{%
\setcounter{choshai}{\m@ne}%
\setcounter{choshaii}{\z@}%
\@for\member:=#1\do{\addtocounter{choshai}{\@ne}}%
\@for\member:=#1\do{\addtocounter{choshaii}{\@ne}%
\ifnum\c@choshaii<\c@choshai%
\ifnum\c@choshai<1\relax\expandafter%\J
\member%
\else%
\ifnum\c@choshai<2\relax\member,
\else\expandafter%\J
\member,%
\fi\fi%
\else%
\ifnum\c@choshaii=\c@choshai\expandafter%\J
\member%,
and%
\else%
\expandafter%\J
\member%
\fi\fi\ignorespaces%
}}






\long\def\authorentry#1{%
\setcounter{choshai}{\m@ne}%
\setcounter{choshaii}{\z@}%
\@for\member:=#1\do{\addtocounter{choshai}{\@ne}}%
\@for\member:=#1\do{\addtocounter{choshaii}{\@ne}%
\ifnum\c@choshaii<\c@choshai%
\ifnum\c@choshai<1\relax\expandafter%\J
\member%
\else%
\ifnum\c@choshai<2\relax\member\Nakaguro%
\else\expandafter%\J
\member\Nakaguro%
\fi\fi%
\else%
\ifnum\c@choshaii=\c@choshai\expandafter%\J
\member\NAkaguro%
\else
\expandafter%\J
\member%
\fi\fi%
}}


%%%%%%%%%%%%%% 
\newif\ifAND \ANDfalse

\def\Nakaguro{,\space}
\def\NAkaguro{,\enskip and\ }
\def\NAkaMEguro{,\\ and\ }

\newif\ifCHOSHAHUTARI \CHOSHAHUTARIfalse
\def\NAkaguroHUTARI{\ and\ }


%\def\NAkaguro{,\ }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\long\def\authorentry#1{%
\setcounter{choshai}{\m@ne}%
\setcounter{choshaii}{\z@}%
\@for\member:=#1\do{\addtocounter{choshai}{\@ne}}%
\@for\member:=#1\do{\addtocounter{choshaii}{\@ne}%
\ifnum\c@choshaii<\c@choshai%
\ifnum\c@choshai<1\relax\expandafter%\J
\member%
\else%
\ifnum\c@choshai<2\relax\member\Nakaguro%
\else\expandafter%\J
\member\Nakaguro%
\fi\fi%
\else%
\ifnum\c@choshaii=\c@choshai\expandafter%\J
\member\NAkaguro%
\else
\expandafter%\J
\member%
\fi\fi%
}}




\def\TESTREVi{1yoritiisai}
\def\TESTREVii{2yoritiisai}


\long\def\authorentry#1{%
\setcounter{choshai}{\m@ne}%
\setcounter{choshaii}{\z@}%
\@for\member:=#1\do{\addtocounter{choshai}{\@ne}}%
\@for\member:=#1\do{\addtocounter{choshaii}{\@ne}%
\ifnum\c@choshaii<\c@choshai%
\ifnum\c@choshai<1\relax\expandafter%\J
\member%
\else%
\ifnum\c@choshai<2\relax\member\Nakaguro%
\else\expandafter%\J
\member\Nakaguro%
\fi\fi%
\else%
\ifnum\c@choshaii=\c@choshai\expandafter%\J
%%%%%%%%%%%%%%%%%%%%%%%%%%% 2
\ifnum\c@choshai=1
\member\NAkaguroHUTARI%
\else%%%%%%%%%%%%%%%%%%%%%% 2
%%%
\ifAND
\member\NAkaMEguro%
\else
\member\NAkaguro%
\fi
\fi%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2
%%%
\else
\expandafter%\J
\member%
\fi\fi%
}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%% authot 
\newcounter{shozokusanshoui}
\newcounter{shozokusanshouii}


\def\COMMAi{,}
\def\COMMAii{,}


\def\AffiliateLabelRef#1{%%
\@for\refmember:=#1\do{\ref{\refmember}}%
}%%%


\long\def\AffiliateLabelRef#1{%
\setcounter{shozokusanshoui}{\m@ne}%
\setcounter{shozokusanshouii}{\z@}%
\@for\refmember:=#1\do{\addtocounter{shozokusanshoui}{\@ne}}%
\@for\refmember:=#1\do{\addtocounter{shozokusanshouii}{\@ne}%
\ifnum\c@shozokusanshouii<\c@shozokusanshoui
 \ifnum\c@shozokusanshoui<1\relax\expandafter%\J
 \ref{\refmember}%
\else
\ifnum\c@shozokusanshoui<2\relax\ref{\refmember}\COMMAi%\Nakaguro%
\else \expandafter%\J
\ref{\refmember}\COMMAi%\Nakaguro%
\fi\fi
\else
\ifnum\c@shozokusanshouii=\c@shozokusanshoui\expandafter%\J
\ref{\refmember}\COMMAii%\NAkaguro%
\else
\expandafter%\J
\ref{\refmember}%
\fi\fi
}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



\@definecounter{SICEauthorSICEaffiliate}
\def\theSICEauthorSICEaffiliate{\@arabic\c@SICEauthorSICEaffiliate}


\@definecounter{SICEauthor}
\def\theSICEauthor{\@arabic\c@SICEauthor}




%%%
\def\author#1#2{\refstepcounter{SICEauthor}%\theSICEauthor%
%%%%%%%%%%%%%%%% % #1$^\mathrm{\ref{#2}}$
\AUTHORsc{#1}$^\mathrm{\AffiliateLabelRef{#2}}$\ignorespaces%
}
%%\AUTHORsc{


%\long\def\AUTHOR#1{\ignorespaces\Mauthor{\ignorespaces\authorentry{#1}\ignorespaces}\ignorespaces}

\long\def\AUTHOR{\@ifstar{\AUTHOR@and}{\AUTHOR@normal}}

\long\def\AUTHOR@and#1{\ANDtrue\ignorespaces\Mauthor{\ignorespaces\authorentry{#1}\ignorespaces}\ignorespaces}

\long\def\AUTHOR@normal#1{\ignorespaces\Mauthor{\ignorespaces\authorentry{#1}\ignorespaces}\ignorespaces}



%%%%%%%% affiliate %%%%%
\def\sice@fnsymbol#1{%
 \ifnum\c@SICEauthorSICEaffiliate%\chk@alcnt
>9\relax
  \ifcase #1\or {*}1\or {*}2\or {*}3\or {*}4\or {*}5\or {*}6\or {*}7\or
   {*}8\or {*}9\or {*}10\or {*}11\or {*}12\or {*}13\or {*}14\or {*}15\or
    \dagger
   \else\@ctrerr\fi\relax
 \else
  \ifcase #1\or{*}\or {*}{*}\or {*}{*}{*}\or {*}{*}{*}{*}\or
   {*}{*}{*}{*}{*}\or {*}{*}{*}{*}{*}{*}\or {*}{*}{*}{*}{*}{*}{*}\or
   {*}{*}{*}{*}{*}{*}{*}{*}\or {*}{*}{*}{*}{*}{*}{*}{*}{*}\or
    \or \or \or \or \or \or \dagger
   \else\@ctrerr\fi\relax
 \fi%
}



\newbox\@Maffiliate
\def\Maffiliate#1{\setbox\@Maffiliate=\hbox{\begin{tabular}{l}#1\end{tabular}}%
}


\def\Maffiliate#1{\setbox\@Maffiliate=\hbox{#1}%
}


%\def\Maffiliate#1{#1}
\def\Maffiliate#1{\setbox\@Maffiliate=\hbox{#1}%
}



%%% \box 
\def\affiliate#1#2{%{
%\def\thempfn{}%
%\leftskip-2.5mm%%%
%\small
\let\@arabic\sice@fnsymbol%
\refstepcounter{SICEauthorSICEaffiliate}%
\label{#2}%
%\leavevmode%
%\hspace*{-11.552pt}\hbox to11.552pt%
%\hspace*{-17.41687pt}\hbox to14.41687pt%
%{$^\mathrm{\ref{#2}}$}%\setbox0=\hbox{$^\mathrm{\ref{#2}}$}\the\wd0%
%\begin{minipage}{0mm}
#1%
%\end{minipage}
%}%
\ignorespaces}


%%% \box 
\def\affiliate#1#2{{\def\thempfn{}%
%\leftskip2.5mm%%%
\small
  \let\@arabic\sice@fnsymbol
\refstepcounter{SICEauthorSICEaffiliate}%
\label{#2}%
\leavevmode%
\hspace*{-11.552pt}\hbox to11.552pt%
%\hspace*{-17.41687pt}\hbox to14.41687pt%
{\hss$^\mathrm{\ref{#2}}$\ }%\setbox0=\hbox{$^\mathrm{\ref{#2}}$}\the\wd0%
#1%
}%
}












\newenvironment{shozokulist}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\shozokulabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}





\newcounter{shozokui}
\newcounter{shozokuii}


\def\KAIGYOi{\\\ignorespaces}
\def\KAIGYOii{\\\ignorespaces}


\def\KAIGYOi{\par\ignorespaces}
\def\KAIGYOii{\par\ignorespaces}


\long\def\affiliateentry#1{%
\setcounter{shozokui}{\m@ne}%
\setcounter{shozokuii}{\z@}%
\@for\member:=#1\do{\addtocounter{shozokui}{\@ne}}%
\@for\member:=#1\do{\addtocounter{shozokuii}{\@ne}%
\ifnum\c@shozokuii<\c@shozokui%
 \ifnum\c@shozokui<1\relax\expandafter%\J
 \member%
\else
\ifnum\c@shozokui<2\relax\member\KAIGYOi%\Nakaguro%
\else \expandafter%\J
\member\KAIGYOi%\Nakaguro%
\fi\fi
\else
\ifnum\c@shozokuii=\c@shozokui\expandafter%\J
\member\KAIGYOii%\NAkaguro%
\else
\expandafter%\J
\member%
\fi\fi
}}



\long\def\AFFILIATE#1{\Maffiliate{\gdef\@affiliate{\affiliateentry{#1}}}}


%\long\def\AFFILIATE#1{{\let\affiliate\relax\xdef\@AFFILIATElist{\zap@space#1 \@empty}}%
%\Maffiliate{\gdef\@affiliate{\affiliateentry{\@AFFILIATElist}}}}



%%%%%%%% affiliate %%%%%













%%%% SANBI
\newcommand*{\email}[1]{\gdef\authors@mail{#1}}
% \newcommand*{\email}[1]{{%
%   \def\@makefntext{\parindent1em \noindent}
%   \footnotetext[0]{\itshape author's e-mail:\ #1}}}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% 10
%%% \title 210L
\newdimen\TITLEheight
\setlength{\TITLEheight}{9\baselineskip}%%%%% 10L
\addtolength{\TITLEheight}{\topskip}% 


\newdimen\Titleheight
\setlength{\Titleheight}{5\baselineskip}%%%%% 7L
\addtolength{\Titleheight}{\topskip}% 



\newdimen\titleabstractsep
\titleabstractsep4.25mm%6.25mm 32\Q

\def\@maketitle{%
  \newpage
  \null
%  \vskip 2em%
  \bgroup\hbadness10001%
   \small
   \make@titlehead
  \egroup\vspace*{12mm}%{3mm}%%% 15
  \begin{Center}%\hbadness10001%
  \let \footnote \thanks
%{\fboxsep=0pt\colorbox{red}{%
%\vbox to\TITLEheight{%
%\fboxsep=0pt\fcolorbox{green}{red}{%
\vbox% to\Titleheight
{%
    {\mathversion{bold}\LARGE\XXIQ\bfseries \@title \par}%
\vskip2mm
    \ifx\@subtitle\empty\vspace*{-2mm}\else
%    {\mathversion{bold}\LARGE\XXIQ\bfseries \@subtitle \par}\vss}\fi}}
    {\mathversion{bold}\LARGE\XXIQ\bfseries \@subtitle \par}\fi\vss}%}}
\par%
\vspace*{7.75mm}%{-2.25mm}%\vskip6mm%-1mm%    \vskip 1.5em%
    {\Large%\fontsize{16\Q}{20\Q}\selectfont
%      \lineskip .5em%
      \begin{tabular}[t]{c}%
\@Mauthor%\box\@Mauthor%
%        \@author
      \end{tabular}\vfill
\par}
%\vss}%}}%% 
%    \vskip 1em%
%    {\large \@date}%
  \end{Center}%
  \par
%%%
%
\vskip\titleabstractsep%6.25mm%% 32Q
%\begin{tabular}[t]{c}%
  \ifvoid\@abstractbox
   \vskip-1\baselineskip
  \else
   \hfil\box\@abstractbox\par
  \fi
%\end{tabular}
  \ifvoid\@keywordsbox
  \else
   \vskip15\Q
   \hfil\box\@keywordsbox\par
  \fi
%%%
%
  \vskip 2\Cvs%\box\Entrybox
%\footnotetext{\box\@affiliatebox}
%\box\@Maffiliate
%\box\@affiliatebox%\@affiliate
\addvspace{\MaketitleIntrosep}%
}
\fi














\setcounter{secnumdepth}{3}
\newcounter {part}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thesection {\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\part{%
   \if@noskipsec \leavevmode \fi
   \par
   \addvspace{4ex}%
   \@afterindentfalse
   \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
       \Large\bfseries \partname~\thepart
       \par\nobreak
     \fi
     \huge \bfseries #2%
     \markboth{}{}\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}
\def\@spart#1{%
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \huge \bfseries #1\par}%
     \nobreak
     \vskip 3ex
     \@afterheading}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

\newbox\@tempboxb
\newdimen\SECTwd





\def\@startsection#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
   \par \@tempskipa #4\relax
   \@afterindenttrue
   \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi %% >
   \if@nobreak
    \everypar{}%
   \else
    \addpenalty\@secpenalty
     \ifnum #2=\@ne
       \vskip-\prevdepth \prevdepth\z@ \vskip\Cvs
       \advance\@tempskipa-\Cvs %\vspace*{\@tempskipa}%
     \else
      \addvspace\@tempskipa
     \fi
   \fi
 \@ifstar{\@ssect{#3}{#4}{#5}{#6}}{\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}



\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
%%%%
 \setbox\@tempboxb\hbox{\large\bfseries#6{%
      \@hangfrom{%
%\hangindent=\wd\@tempboxa\hangafter=-10
\hskip #3\relax{\csname #2@font\endcsname \@svsec}}}}%\the\wd\@tempboxb
\setbox\SECTwd=\hbox{%
\begingroup\noindent
    #6{%
      \@hangfrom{%
%\hangindent=\wd\@tempboxa\hangafter=-10
\hskip #3\relax{\csname #2@font\endcsname \@svsec}}%%
       \interlinepenalty \@M %\@secjidori
\shortstack[l]{%
%\noindent\box\@tempboxa
\noindent
#8}\@@par}%
   \endgroup
}
%%%%
  \ifdim \wd\SECTwd > \columnwidth
%%%% 
%    \begingroup
   \noindent%\parbox[t]{\columnwidth}
{\vskip-.25\Cvs\begingroup%
\noindent
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M 
\noindent\hangindent\wd\@tempboxb\hangafter=1
#8\@@par}\addvspace{-.125\Cvs}%
    \endgroup}
\else
    \noindent\begingroup\noindent%\hfil
\hfil%
%%%% 
\ifdim\ht\SECTwd >\baselineskip
%%%%%%
\parbox[t]{\wd\SECTwd}{%
      #6{%\pushtowall{$\star\star$}%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M
#8\@@par}\addvspace{.125\Cvs}
}%
    \endgroup
%%%%%%
\else
%%%%%%
\parbox[t]{\wd\SECTwd}{%
      #6{%\pushtowall{@}%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M
#8\@@par}}%
    \endgroup
%%%%%%
\fi
\fi
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{\let\@makefnmark\sec@makefnmark%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\def\@xsect#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}
\def\@seccntformat#1{\bfseries\csname the#1\endcsname.\quad}


\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
%%%
\setbox\SECTwd=\hbox{%
\begingroup\noindent
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M %
\shortstack[l]{
\noindent
#5}\@@par}%
    \endgroup
}
%%

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \ifdim \wd\SECTwd > \columnwidth
   \noindent%
{\begingroup
      #4{\let\@makefnmark\sec@makefnmark%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M 
\noindent%\hangindent\wd\@tempboxb\hangafter=1
#5\@@par}%
    \endgroup}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\else
    \noindent\begingroup\hfil
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
\fi
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}



\newcommand{\section}{\@startsection{section}{1}{0em}%
%   {.75\Cvs \@plus.1mm \@minus.1mm}%
%   {.25\Cvs \@plus.1mm \@minus.1mm}%
%   {4.125mm \@plus.25mm \@minus.5mm}%
%   {.125\Cvs \@plus0.25mm \@minus0.5mm}%
%   {4.125mm \@plus.125mm \@minus.25mm}%
%   {.125\Cvs \@plus-.125mm \@minus-.25mm}%
   {.00001\Cvs \@plus.00001mm \@minus.00001mm}%
   {.00001\Cvs \@plus.00001mm \@minus.00001mm}%
   {\reset@font\large%\slshape
\bfseries
\mathversion{bold}%
}}




\renewcommand{\section}{\@startsection{section}{1}{0em}%
%   {.75\Cvs \@plus.1mm \@minus.1mm}%
%   {.25\Cvs \@plus.1mm \@minus.1mm}%
%   {4.125mm \@plus.25mm \@minus.5mm}%
%   {.125\Cvs \@plus0.25mm \@minus0.5mm}%
%   {4.125mm \@plus.125mm \@minus.25mm}%
%   {.125\Cvs \@plus-.125mm \@minus-.25mm}%
   {.00001\Cvs \@plus.00001mm \@minus.00001mm}%
%   {.00001mm \@plus.00001mm \@minus.00001mm}%
   {.00001mm}%
   {\reset@font\large%\slshape
\bfseries
\mathversion{bold}%
}}










\renewcommand{\section}{\@startsection{section}{1}{0em}%
%   {.75\Cvs \@plus.1mm \@minus.1mm}%
%   {.25\Cvs \@plus.1mm \@minus.1mm}%
%   {4.125mm \@plus.25mm \@minus.5mm}%
%   {.125\Cvs \@plus0.25mm \@minus0.5mm}%
%   {4.125mm \@plus.125mm \@minus.25mm}%
%   {.125\Cvs \@plus-.125mm \@minus-.25mm}%
   {.00001\Cvs \@plus.00001mm \@minus.00001mm \addvspace{-1mm}}%
%   {.00001mm \@plus.00001mm \@minus.00001mm}%
   {1.00001mm}%
   {\reset@font\large%\slshape
\bfseries
\mathversion{bold}%
}}




\renewcommand{\section}{\@startsection{section}{1}{0em}%
   {.00001\Cvs \@plus.00001mm \@minus.5mm \addvspace{-1mm}}%
   {1.00001mm  \@minus.5mm}%
   {\reset@font\large%\slshape
\bfseries
\mathversion{bold}%
}}







\def\@startsectionB#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty
%%%%
     \ifnum #2=\@ne
       \vskip-\prevdepth \prevdepth\z@ \vskip\Cvs
       \advance\@tempskipa-\Cvs% \vspace*{\@tempskipa}%
     \else
%%%
\addvspace\@tempskipa
    \fi
  \fi
  \@ifstar
    {\@ssectB{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sectB{#1}{#2}{#3}{#4}{#5}{#6}}}}

\def\@sectB#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsecB\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsecB{\@seccntformatB{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsecB}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\let\@makefnmark\sec@makefnmark%
\hskip #3\relax
      \@svsecB #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsectB{#5}}
\def\@xsectB#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}
\def\@seccntformatB#1{\bfseries\csname the#1\endcsname\quad}
\def\@ssectB#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{\let\@makefnmark\sec@makefnmark%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
  \else
    \def\@svsechdB{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}












\newcommand{\subsection}{\@startsectionB{subsection}{2}{0em}%
%   {4.125mm \@plus.25mm \@minus.5mm}%
%   {.125\Cvs \@plus0.25mm \@minus0.5mm}%
   {1\Cvs \@plus.25mm \@minus.5mm}%
%   {.00001\Cvs \@plus0.0001mm \@minus0.5mm}%
{0.00001mm}
   {\reset@font\normalsize
\bfseries\mathversion{bold}}}




\renewcommand{\subsection}{\@startsectionB{subsection}{2}{0em}%
%   {4.125mm \@plus.25mm \@minus.5mm}%
%   {.125\Cvs \@plus0.25mm \@minus0.5mm}%
   {1\Cvs \@plus.25mm \@minus.5mm \addvspace{-1mm}}%
%   {.00001\Cvs \@plus0.0001mm \@minus0.5mm}%
{1.00001mm}
   {\reset@font\normalsize
\bfseries\mathversion{bold}}}





\renewcommand{\subsection}{\@startsectionB{subsection}{2}{0em}%
   {3.25mm \@plus.00001mm \@minus.5mm}%
{1.00001mm \@minus.5mm}
   {\reset@font\normalsize
\bfseries\mathversion{bold}}}


\def\@startsectionC#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty
%%%%
     \ifnum #2=\@ne
       \vskip-\prevdepth \prevdepth\z@ \vskip\Cvs
       \advance\@tempskipa-\Cvs \vspace*{\@tempskipa}%
     \else
%%%
\addvspace\@tempskipa
    \fi
  \fi
  \@ifstar
    {\@ssectC{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sectC{#1}{#2}{#3}{#4}{#5}{#6}}}}

\def\@sectC#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsecC\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsecC{\@seccntformatC{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsecC}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\let\@makefnmark\sec@makefnmark%
\hskip #3\relax
      \@svsecC #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsectC{#5}}
\def\@xsectC#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechd \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}
\def\@seccntformatC#1{\csname the#1\endcsname\quad}
\def\@ssectC#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{\let\@makefnmark\sec@makefnmark%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
  \else
    \def\@svsechdC{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}










\newcommand{\subsubsection}{\@startsectionC{subsubsection}{3}{0em}%
   {.00001\Cvs \@plus.1mm \@minus.1mm}%
   {.00001\Cvs \@plus.1mm \@minus.1mm}%
   {\reset@font\normalsize}}




\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\if@titlepage
  \newenvironment{ORGabstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \begin{center}%
        \bfseries \abstractname
        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
  \newenvironment{ORGabstract}{%
      \if@twocolumn
        \section*{\abstractname}%
      \else
        \small
        \begin{center}%
          {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
        \end{center}%
        \quotation
      \fi}
      {\if@twocolumn\else\endquotation\fi}
\fi


\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\if@compatibility
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi
\newcommand\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\thesection{\@Alph\c@section}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.12mm}%{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand \theequation {\@arabic\c@equation}



\def\sice@shortstack{\@ifnextchar[% ]
 \@sice@shortstack{\@sice@shortstack[c]}}
\def\@sice@shortstack[#1]{%
  \leavevmode
  \vbox\bgroup
    %%\baselineskip-\p@\lineskip 3\p@
    \let\mb@l\hss\let\mb@r\hss
    \expandafter\let\csname mb@#1\endcsname\relax
    \let\\\@stackcr
    \@ishortstack}

\long\def\@caption#1[#2]#3{\par
 %%\addcontentsline{\csname ext@#1\endcsname}{#1}%
 %% {\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
 \begingroup
  \@parboxrestore
  \if@minipage
   \@setminipage
  \fi
  \footnotesize
  \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
 \endgroup}



\def\@floatboxreset{%
 \reset@font
% \small\tabcolsep.5em
\footnotesize
 \@setminipage
}

\def\floatenv{%
 \let\center\Center
 \def\verbatimsize{\small}%
}


\newdimen\capwidth

\long\def\@makecaption#1#2{%
 \vskip\abovecaptionskip
 \setbox\@tempboxa\hbox{{#1}\hskip1em\sice@shortstack[l]{#2}}%
 \@tempdima \ht\@tempboxa
 \advance \@tempdima \dp\@tempboxa
 \setbox\@tempboxb\hbox{#1\hskip1em}%
 \ifdim \@tempdima > \baselineskip
  \ifdim \wd\@tempboxa > \capwidth
   \hfil\parbox[t]{\capwidth}{\hangindent\wd\@tempboxb 
    {#1}\hskip1em #2}\par
    \hrule \@height \z@
  \else
   \hfil\parbox[t]{\wd\@tempboxa}{\hangindent\wd\@tempboxb 
    {#1}\hskip1em #2}\par
    \hrule \@height \z@
  \fi
 \else
  \ifdim \wd\@tempboxa > \capwidth
   \hfil\parbox[t]{\capwidth}{\hangindent\wd\@tempboxb 
    {#1}\hskip1em #2}\par
    \hrule \@height \z@
  \else
   \hbox to\hsize{\hss\box\@tempboxa\hss}%
  \fi
 \fi
 \vspace{\belowcaptionskip}%
}



\newcounter{figure}
\renewcommand \thefigure {\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}


\newenvironment{figure}
               {\floatenv\capwidth\columnwidth
                \abovecaptionskip1.5mm\belowcaptionskip\z@\let\center=\Center\@float{figure}}
               {\end@float}

\newenvironment{figure*}
               {\floatenv\capwidth.67\textwidth
                \abovecaptionskip1.5mm\belowcaptionskip\z@\let\center=\Center\@dblfloat{figure}}
               {\end@dblfloat}


\newcounter{table}
\renewcommand\thetable{\@arabic\c@table}

\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}

\newenvironment{table}
               {\floatenv\capwidth\columnwidth
                \abovecaptionskip\z@\belowcaptionskip1.5mm\let\center=\Center\@float{table}}
               {\end@float}

\newenvironment{table*}
               {\floatenv\capwidth.67\textwidth
                \abovecaptionskip\z@\belowcaptionskip1.5mm\let\center=\Center\@dblfloat{table}}
               {\end@dblfloat}


\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}



\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{3}
\newcommand\tableofcontents{%
    \section*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty\@secpenalty
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
       \if@compatibility
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
      \fi
    \endgroup
  \fi}
\newcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{1.0em \@plus\p@}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}
\newcommand*\l@subsection{\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{7.0em}{4.1em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{10em}{5em}}
\newcommand\listoffigures{%
    \section*{\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
    \@starttoc{lof}%
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \section*{\listtablename
      \@mkboth{%
          \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
    \@starttoc{lot}%
    }
\let\l@table\l@figure


\newdimen\bibindent
\setlength\bibindent{1.5em}


\newenvironment{thebibliography}[1]
     {\small\section*{\small\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
        \topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty


\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\section*{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}

\renewcommand\footnoterule{%
  \kern-3\p@
%  \hrule\@width.4\columnwidth
  \hrule\@width \columnwidth
  \kern2.6\p@}

\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}

\renewcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}






\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\refname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Fig.}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{7mm}%{28\Q}
\setlength\columnseprule{0\p@}
\pagestyle{headings}%{plain}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
% \raggedbottom
\else
  \onecolumn
\fi




%%%% 60
\setlength{\textheight}{59\baselineskip}%%%%% 28L
\addtolength{\textheight}{\topskip}% 

%%%% 
\setlength{\textwidth}{177mm}%{708\Q} %% 
\setlength\paperheight {297mm}% 	a5
\setlength\paperwidth  {210mm}%
%\setlength{\footskip}{8mm}

%%% 
\setlength{\parindent}{9pt}
\setlength{\parskip}{0mm}






%%%
%%%
%%%
%%%A4
%\paperwidth210mm
%\paperheight297mm

\columnsep7mm

%\headsep7mm
%\footskip9.25mm



%%%
%\textwidth81.25mm
%\textwidth2\textwidth
%\advance\textwidth6.5mm



\oddsidemargin\paperwidth
\advance\oddsidemargin-\textwidth
\oddsidemargin.5\oddsidemargin
\advance\oddsidemargin-1in
\evensidemargin\oddsidemargin

\topmargin=0mm
\advance\topmargin-13.5mm
%\topmargin0mm
%\advance\topmargin-1in
%\advance\topmargin-\headsep
%\advance\topmargin-\headheight
%\newdimen\TenTi
%\TenTi=\topmargin\advance\paperheight-\textheight
%\TenTi=.5\TenTi
%\advance\topmargin-\TenTi
%\topmargin0pt%-28.5pt
%\headsep0pt
%\headheight0pt
%\advance\topmargin-.5in



\setlength\fboxrule{.12mm}



%\newcounter{Lastpage}

%\AtEndDocument{%
% \clearpage
% \addtocounter{page}{-1}%
% \immediate\write\@auxout
%  {\string\newlabel{sice@lastpage}{{}{\thepage}}}%
 %\addtocounter{page}{1}%
%\theLastpage=\thepage
%\value{page}
%\setcounter{Lastpage}{\thepage}
%}





\AtEndDocument{%
 \clearpage
 \addtocounter{page}{-1}%
 \immediate\write\@auxout
%  {\string\newlabel{sice@lastpage}{{}{\thepage}}}%
\ifnum\the\value{page}<10   {\string\newlabel{sice@lastpage}{{}{00\thepage}}}%
\else
\ifnum\the\value{page}<100   {\string\newlabel{sice@lastpage}{{}{0\thepage}}}%
\else
{\string\newlabel{sice@lastpage}{{}{\thepage}}}%
\fi\fi
}









\newdimen\mathindent


\AtBeginDocument{%
\mathindent6.5mm%2em%
\renewcommand\[{\relax
                \ifmmode\@badmath
                \else
                  \@InListEnv
                  \begin{trivlist}%
                    \@beginparpenalty\predisplaypenalty
                    \@endparpenalty\postdisplaypenalty
                    \item[]\leavevmode
                    \hb@xt@\linewidth\bgroup $\m@th\displaystyle %$
                      \hskip\mathindent\bgroup
                \fi}
\renewcommand\]{\relax
                \ifmmode
                      \egroup $\hfil% $
                    \egroup
                  \end{trivlist}%
                \else \@badmath
                \fi}
\renewenvironment{equation}%
    {\@beginparpenalty\predisplaypenalty
     \@endparpenalty\postdisplaypenalty
     \refstepcounter{equation}%
     \@InListEnv
     \trivlist \item[]\leavevmode
       \hb@xt@\linewidth\bgroup $\m@th% $
         \displaystyle
         \hskip\mathindent}%
        {$\hfil % $
         \displaywidth\linewidth\hbox{\@eqnnum}%
       \egroup
     \endtrivlist}
\renewenvironment{eqnarray}{%
    \stepcounter{equation}%
    \def\@currentlabel{\p@equation\theequation}%
    \global\@eqnswtrue\m@th
    \global\@eqcnt\z@
    \tabskip\mathindent
    \let\\=\@eqncr
    \@InListEnv
    \setlength\abovedisplayskip{\topsep}%
    \ifvmode
      \addtolength\abovedisplayskip{\partopsep}%
    \fi
    \addtolength\abovedisplayskip{\parskip}%
    \setlength\belowdisplayskip{\abovedisplayskip}%
    \setlength\belowdisplayshortskip{\abovedisplayskip}%
    \setlength\abovedisplayshortskip{\abovedisplayskip}%
    $$\everycr{}\halign to\linewidth% $$
    \bgroup
      \hskip\@centering
      $\displaystyle\tabskip\z@skip{##}$\@eqnsel&%
      \global\@eqcnt\@ne \hskip.8\arraycolsep \hfil${##}$\hfil&%
      \global\@eqcnt\tw@ \hskip.8\arraycolsep
        $\displaystyle{##}$\hfil \tabskip\@centering&%
      \global\@eqcnt\thr@@
        \hb@xt@\z@\bgroup\hss##\egroup\tabskip\z@skip\cr}%
      {\@@eqncr
    \egroup
    \global\advance\c@equation\m@ne$$% $$
    \@ignoretrue
    }
%%%%%%%
\newenvironment{Meqnarray}{%
    \stepcounter{equation}%
    \def\@currentlabel{\p@equation\theequation}%
    \global\@eqnswtrue\m@th
    \global\@eqcnt\z@
    \tabskip\mathindent
    \let\\=\@eqncr
    \@InListEnv
    \setlength\abovedisplayskip{\topsep}%
    \ifvmode
      \addtolength\abovedisplayskip{\partopsep}%
    \fi
    \addtolength\abovedisplayskip{\parskip}%
    \setlength\belowdisplayskip{\abovedisplayskip}%
    \setlength\belowdisplayshortskip{\abovedisplayskip}%
    \setlength\abovedisplayshortskip{\abovedisplayskip}%
    $$\everycr{}\halign to\linewidth% $$
    \bgroup
      \hskip\@centering
      $\displaystyle\tabskip\z@skip{##}$\@eqnsel&%
      \global\@eqcnt\@ne \hskip0\arraycolsep \hfil${##}$\hfil&%
      \global\@eqcnt\tw@ \hskip0\arraycolsep
        $\displaystyle{##}$\hfil \tabskip\@centering&%
      \global\@eqcnt\thr@@
        \hb@xt@\z@\bgroup\hss##\egroup\tabskip\z@skip\cr}%
      {\@@eqncr
    \egroup
    \global\advance\c@equation\m@ne$$% $$
    \@ignoretrue
    }
%%%%%%%
\newenvironment{Eeqnarray}{%
    \stepcounter{equation}%
    \def\@currentlabel{\p@equation\theequation}%
    \global\@eqnswtrue\m@th
    \global\@eqcnt\z@
    \tabskip\mathindent
    \let\\=\@eqncr
    \@InListEnv
    \setlength\abovedisplayskip{\topsep}%
    \ifvmode
      \addtolength\abovedisplayskip{\partopsep}%
    \fi
    \addtolength\abovedisplayskip{\parskip}%
    \setlength\belowdisplayskip{\abovedisplayskip}%
    \setlength\belowdisplayshortskip{\abovedisplayskip}%
    \setlength\abovedisplayshortskip{\abovedisplayskip}%
    $$\everycr{}\halign to\linewidth% $$
    \bgroup
      \hskip\@centering
      $\displaystyle\tabskip\z@skip{##}$\@eqnsel&%
      \global\@eqcnt\@ne \hskip0.5\arraycolsep \hfil${##}$\hfil&%
      \global\@eqcnt\tw@ \hskip0.5\arraycolsep
        $\displaystyle{##}$\hfil \tabskip\@centering&%
      \global\@eqcnt\thr@@
        \hb@xt@\z@\bgroup\hss##\egroup\tabskip\z@skip\cr}%
      {\@@eqncr
    \egroup
    \global\advance\c@equation\m@ne$$% $$
    \@ignoretrue
    }
%%\endinput
%%
%% End of file `fleqn.clo'.

\def\@InListEnv{%
 \ifdim\topsep=\z@
  \@listi
 \fi
}

\def\@eqnnum{{\normalfont\normalcolor
  (\theequation)
  \hskip1em\mbox{}}}

\def\tagform@#1{{\normalfont\normalcolor
  (\theequation)
  \hskip1em\mbox{}}}

  \def\eqref#1{{\normalfont\normalcolor (\theequation)}}%
}



%\def\thefootnote{\sice@fnsymbol\c@footnote}%{\@arabic\c@footnote}

\def\thefootnote{\@arabic\c@footnote}%



\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule \@width \columnwidth
  \kern 2.6\p@}

\renewcommand\@makefntext[1]{%
\small
 \everypar={\hangafter=1\relax\hangindent=2em\advance \hangindent by5\Q}%
 \parindent2em
  \noindent
  \hskip5\Q
  \hbox to 2em{\@thefnmark\hss}%
 #1}


\newdimen\FNmarkwidth

\renewcommand\@makefntext[1]{%
\small
\setbox\FNmarkwidth=\hbox{\@thefnmark\hskip5\Q\hss}
 \everypar={\hangafter=1\relax\hangindent=\wd\FNmarkwidth\advance \hangindent by5\Q}%
 \parindent\wd\FNmarkwidth\advance \parindent by5\Q%2em
  \noindent
  \hskip5\Q
%  \hbox to \wd\FNmarkwidth{\@thefnmark\hss}%
  \hbox to \wd\FNmarkwidth{\@thefnmark\hss}\the\wd\FNmarkwidth%
 #1}




\renewcommand\@makefntext[1]{%
\small
 \everypar={\hangafter=1\relax\hangindent=21.5572pt\advance \hangindent by5\Q}%
 \parindent=21.5572pt\advance \parindent by5\Q
  \noindent
  \hskip5\Q
%  \hbox to \wd\FNmarkwidth{\@thefnmark\hss}%
  \hbox to 21.5572pt{\hss\@thefnmark\hskip5\Q}%
 #1}





\renewcommand\@makefntext[1]{%
\small\leftskip2em
% \everypar={\hangafter=1\relax\hangindent=11.552pt}%
% \parindent=11.552pt%\advance \parindent by5\Q
%  \noindent
%  \hskip5\Q
%  \hbox to \wd\FNmarkwidth{\@thefnmark\hss}%
\leavevmode\hspace*{-11.552pt}\hbox to 11.552pt{\hss\scriptsize$^{\@thefnmark}$\ %\hskip5\Q
}%
 #1}




\def\@makefnmark{%
  \hbox{$^{\mbox{\tiny\@thefnmark}}$}%
}


\def\sec@makefnmark{%
  \hbox to \z@{\normalfont $^{\mbox{\tiny\@thefnmark}}$\hss}%
 }















\newenvironment{biography}{%
 \footnotesize\normalfont
 \parindent\z@
 \vskip\baselineskip
 \penalty\@medpenalty
 \hbox to \hsize{\leaders
  \hbox{\vrule \@width.1mm \@height 1mm\hskip.4mm}\hfil}%
 \penalty\@M
  \let\@profile\@eprofile
  \let\n@profile\n@eprofile
\vskip1\Cvs%  \vskip2mm
 }{\vskip-1mm
   \hbox to \hsize{\leaders
    \hbox{\vrule \@width.1mm \@height 1mm\hskip.4mm}\hfil}\par
  }

\def\profile{\@ifstar{\n@profile}{\@profile}}

%% \t{oo} causes error
\def\sice@sc#1{#1\fontsize{9\JQ}{13\h}\selectfont}

\newcounter{profile}


\def\fmt@pro@pic#1{%
 \begin{minipage}[t]{16mm}%
  \leavevmode\lower17.5mm
  \vbox to 20mm{%
   \IfFileExists{a\the\c@profile.eps}{%
    \resizebox{16mm}{20mm}{\includegraphics{a\the\c@profile.eps}}%
   }{%
     \hrule \@height .1mm
     \hbox to 16mm{\vrule \@width .1mm \@height 19.8mm\hss
                   \vrule \@width .1mm \@height 19.8mm}%
     \hrule \@height .1mm
    }%
  }%
 \end{minipage}%
 \hfill
 \begin{minipage}[t]{66.25mm}% 22zw
  \hskip2.75mm
  #1\par
 \end{minipage}%
}














\def\fmt@pro@pic#1{%
 \begin{minipage}[t]{\columnwidth}%{16mm}%
%  \leavevmode\lower17.5mm
 \leavevmode%\raise-127.5mm
  \vbox to 20mm{%
   \IfFileExists{a\the\c@profile.eps}{%
%\leavevmode\smash{\llap{\lower21.5mm\hbox to 20mm{%%%%%%%%%%%%%%%%%%%%%%%
\leavevmode\smash{\llap{\raise10mm\hbox to 20mm{%%%%%%%%%%%%%%%%%%%%%%%
    \resizebox{16mm}{20mm}{\includegraphics{a\the\c@profile.eps}}%
\hss}}}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   }{%
     \hrule \@height .1mm
     \hbox to 16mm{\vrule \@width .1mm \@height 19.8mm\hss
                   \vrule \@width .1mm \@height 19.8mm}%
     \hrule \@height .1mm
    }%
  }%
% \end{minipage}%
% \hfill
% \begin{minipage}[t]{66.25mm}% 22zw
\hangindent20mm\hangafter-8\relax
  \hskip2.75mm
  #1\par
 \end{minipage}%
}









\def\fmt@pro@pic#1{%
\noindent\begin{minipage}[t]{\columnwidth}%{16mm}%
\noindent \leavevmode%\raise-127.5mm
%  \noindent\vbox to 20mm{%
   \noindent\IfFileExists{a\the\c@profile.eps}{%
%\leavevmode\smash{\llap{\lower21.5mm\hbox to 20mm{%%%%%%%%%%%%%%%%%%%%%%%
\noindent\leavevmode%\smash{\llap{\raise10mm\hbox to 20mm{%%%%%%%%%%%%%%%%%%%%%%%
    \noindent\smash{\raisebox{-18.75mm}{\pushtowall{\hspace*{-20mm}\resizebox{16mm}{20mm}{\includegraphics{a\the\c@profile.eps}}}}}%
%\hss}}}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   }{%
     \hrule \@height .1mm
     \hbox to 16mm{\vrule \@width .1mm \@height 19.8mm\hss
                   \vrule \@width .1mm \@height 19.8mm}%
     \hrule \@height .1mm
    }%
%  }%
% \end{minipage}%
% \hfill
% \begin{minipage}[t]{66.25mm}% 22zw
\hangindent20mm\hangafter-7\relax
  \hskip2.75mm
  #1\par
 \end{minipage}%
}








\def\fmt@pro@pic#1{%
\noindent\begin{minipage}[t]{\columnwidth}%{16mm}%
\noindent \leavevmode%\raise-127.5mm
%  \noindent\vbox to 20mm{%
   \noindent\IfFileExists{a\the\c@profile.eps}{%
%\leavevmode\smash{\llap{\lower21.5mm\hbox to 20mm{%%%%%%%%%%%%%%%%%%%%%%%
%\noindent\leavevmode%\smas{\llap{\raise10mm\hbox to 20mm{%%%%%%%%%%%%%%%%%%%%%%%
    \noindent{\raisebox{-18.75mm}{\pushtowall{%\hspace*{-20mm}
\resizebox{16mm}{20mm}{\includegraphics{a\the\c@profile.eps}}}}}%
%\hss}}}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   }{%
\noindent{\smash{\raisebox{1mm}
{\pushtowall{%
\begin{minipage}[t]{16mm}
     \hrule \@height .1mm
     \hbox to 16mm{\vrule \@width .1mm \@height 19.8mm\hss
                   \vrule \@width .1mm \@height 19.8mm}%
     \hrule \@height .1mm
\end{minipage}
}}}}
%     \hrule \@height .1mm
%     \hbox to 16mm{\vrule \@width .1mm \@height 19.8mm\hss
%                   \vrule \@width .1mm \@height 19.8mm}%
%     \hrule \@height .1mm
    }%
%  }%
% \end{minipage}%
% \hfill
\pushtowall{\begin{minipage}[t]{\columnwidth}%{66.25mm}% 22zw
\hangindent20mm\hangafter-7\relax
  \hskip2.75mm
  #1%\par
\end{minipage}}
 \end{minipage}%
}











\def\fmt@pro@Ename#1#2{%
 \bgroup
  \normalsize\bfseries 
  \def\tr@name##1 ##2\@nil{##1 \protect\uppercase{\protect\sice@sc ##2}}%
  \protected@edef\@authorname{\expandafter\tr@name #2\@nil\null}%
  \@authorname\ 
 \egroup
 \if #1m\relax
  {\normalsize (Member)}%
 \else
  \if #1s\relax
   {\normalsize (Student Member)}%
  \else
 \if #1f\relax
   {\normalsize (Member, Fellow)}%
  \else
 \if #1h\relax
   {\normalsize (Honorary Member, Fellow)}%
  \else
   \if #1n\relax
    \relax
   \else
    \relax
    \fi
   \fi
  \fi
 \fi
\fi
 \vskip1mm
}






\long\def\@eprofile#1#2#3{%
 \stepcounter{profile}%
 \vbox{%
  \fmt@pro@Ename{#1}{#2}%
  \fmt@pro@pic{#3}%
 }%
 \vskip1\Cvs%6.5mm
}

\long\def\n@eprofile#1#2#3{%
 \stepcounter{profile}%
 \vbox{%
  \fmt@pro@Ename{#1}{#2}%
  {%\normalsize\normalfont
   \hskip5.5mm #3}\par
 }%
 \vskip1\Cvs%6.5mm
}



\renewcommand{\appendix}{%
% \@appendixtrue
 \setcounter{section}{0}%
 \setcounter{subsection}{0}%
 \setcounter{secnumdepth}{2}%
 \setcounter{equation}{0}%
 \setcounter{figure}{0}%
 \setcounter{table}{0}%
 \@addtoreset{equation}{section}%
 \def\theequation{\@Alph\c@section.\protect\,\@arabic\c@equation}%
  \def\thesection{Appendix~\@Alph\c@section}%
 \def\thesubsection{\@Alph\c@section.\protect\,\@arabic\c@subsection}%
 \def\fnum@figure{Fig.\protect\,A.\@arabic\c@figure}%
 \def\fnum@table{Table~A.\@arabic\c@table}%
}








\def\@startsectionAPP#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
   \par \@tempskipa #4\relax
   \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi %% >
   \if@nobreak
    \everypar{}%
   \else
    \addpenalty\@secpenalty
     \ifnum #2=\@ne
       \vskip-\prevdepth \prevdepth\z@ \vskip\Cvs
       \advance\@tempskipa-\Cvs \vspace*{\@tempskipa}%
     \else
      \addvspace\@tempskipa
     \fi
   \fi
 \@ifstar{\@ssectAPP{#3}{#4}{#5}{#6}}{\@dblarg{\@sectAPP{#1}{#2}{#3}{#4}{#5}{#6}}}}



\def\@sectAPP#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsecAPP\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsecAPP{\@seccntformatAPP{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
%%%%
 \setbox\@tempboxb\hbox{\large\bfseries#6{%
      \@hangfrom{%
%\hangindent=\wd\@tempboxa\hangafter=-10
\hskip #3\relax{\csname #2@font\endcsname \@svsecAPP}}}}%\the\wd\@tempboxb
\setbox\SECTwd=\hbox{%
\begingroup\noindent
    #6{%
      \@hangfrom{%
%\hangindent=\wd\@tempboxa\hangafter=-10
\hskip #3\relax{\csname #2@font\endcsname \@svsecAPP}}%%
       \interlinepenalty \@M %\@secjidori
\shortstack[l]{%
%\noindent\box\@tempboxa
\noindent
#8}\@@par}%
   \endgroup
}
%%%%
  \ifdim \wd\SECTwd > \columnwidth
%%%% 
%    \begingroup
   \noindent%\parbox[t]{\columnwidth}
{\vskip-.25\Cvs\begingroup%
\noindent
      #6{%
        \@hangfrom{\hskip #3\relax\@svsecAPP}%
          \interlinepenalty \@M 
\noindent\hangindent\wd\@tempboxb\hangafter=1
#8\@@par}\addvspace{-.125\Cvs}%
    \endgroup}
\else
    \noindent\begingroup\noindent%\hfil
\hfil%
%%%% 
\ifdim\ht\SECTwd >\baselineskip
%%%%%%
\parbox[t]{\wd\SECTwd}{%
      #6{%\pushtowall{$\star\star$}%
        \@hangfrom{\hskip #3\relax\@svsecAPP}%
          \interlinepenalty \@M
#8\@@par}\addvspace{.125\Cvs}
}%
    \endgroup
%%%%%%
\else
%%%%%%
\parbox[t]{\wd\SECTwd}{%
      #6{%\pushtowall{@}%
        \@hangfrom{\hskip #3\relax\@svsecAPP}%
          \interlinepenalty \@M
#8\@@par}}%
    \endgroup
%%%%%%
\fi
\fi
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechdAPP{\let\@makefnmark\sec@makefnmark%
      #6{\hskip #3\relax
      \@svsecAPP #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsectAPP{#5}}
\def\@xsectAPP#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechdAPP \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}

\def\@seccntformatAPP#1{\bfseries Appendix \csname the#1\endcsname\quad}


\def\@ssectAPP#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
%%%
\setbox\SECTwd=\hbox{%
\begingroup\noindent
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M %
\shortstack[l]{
\noindent
#5}\@@par}%
    \endgroup
}
%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \ifdim \wd\SECTwd > \columnwidth
   \noindent%
{\begingroup{\large\bfseries Appendix\hskip1em}%
      #4{\let\@makefnmark\sec@makefnmark%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M 
\noindent%\hangindent\wd\@tempboxb\hangafter=1
#5\@@par}%
    \endgroup}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\else
    \noindent\begingroup\hfil{\large\bfseries Appendix\hskip1em}%
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
\fi
  \else
    \def\@svsechdAPP{#4{\hskip #1\relax #5}}%
  \fi
  \@xsectAPP{#3}}











\renewcommand{\appendix}{\@ifstar{\AppendixNoCNT}{\AppendixCNT}}


\def\AppendixCNT{%
%\renewcommand{\appendix}{%
 \setcounter{section}{-1}%
 \setcounter{subsection}{0}%
 \setcounter{secnumdepth}{2}%
 \setcounter{equation}{0}%
 \setcounter{figure}{-1}%
 \setcounter{table}{0}%
 \@addtoreset{equation}{section}%
 \@addtoreset{figure}{section}%
 \@addtoreset{table}{section}%
 \def\theequation{\@Alph\c@section.\protect\,\@arabic\c@equation}%
%  \def\thesection{Appendix~\@Alph\c@section}%
 \def\thesection{\@Alph\c@section}%
 \def\thesubsection{\@Alph\c@section.\protect\,\@arabic\c@subsection}%
% \def\fnum@figure{Fig.\protect\,A.\@arabic\c@figure}%
% \def\fnum@table{Table~A.\@arabic\c@table}%
 \def\fnum@figure{Fig.~\@Alph\c@section.\@arabic\c@figure}%
 \def\fnum@table{Table~\@Alph\c@section.\@arabic\c@table}%
 \def\thefigure{\@Alph\c@section.\@arabic\c@figure}%
 \def\thetable{\@Alph\c@section.\@arabic\c@table}%
%%%%%%%%%%%%%%5
%\refstepcounter{equation}%{1}
%\refstepcounter{section}%
%\refstepcounter{subsection}%
%\refstepcounter{figure}%
%\refstepcounter{table}%
\refstepcounter{section}%
%}
\renewcommand{\section}{\@startsectionAPP{section}{1}{0em}%
%   {.00001\Cvs \@plus.00001mm \@minus.00001mm}%
  {1\Cvs \@plus.00001mm \@minus.00001mm}%
   {.00001mm}%
   {\reset@font\large%\slshape
\bfseries
\mathversion{bold}%
}}
%}
}








\def\@startsectionAPPSTAR#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
   \par \@tempskipa #4\relax
   \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi %% >
   \if@nobreak
    \everypar{}%
   \else
    \addpenalty\@secpenalty
     \ifnum #2=\@ne
       \vskip-\prevdepth \prevdepth\z@ \vskip\Cvs
       \advance\@tempskipa-\Cvs \vspace*{\@tempskipa}%
     \else
      \addvspace\@tempskipa
     \fi
   \fi
 \@ifstar{\@ssectAPPSTAR{#3}{#4}{#5}{#6}}{\@dblarg{\@sectAPPSTAR{#1}{#2}{#3}{#4}{#5}{#6}}}}



\def\@sectAPPSTAR#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsecAPPSTAR\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsecAPPSTAR{\@seccntformatAPPSTAR{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
%%%%
 \setbox\@tempboxb\hbox{\large\bfseries#6{%
      \@hangfrom{%
%\hangindent=\wd\@tempboxa\hangafter=-10
\hskip #3\relax{\csname #2@font\endcsname \@svsecAPPSTAR}}}}%\the\wd\@tempboxb
\setbox\SECTwd=\hbox{%
\begingroup\noindent
    #6{%
      \@hangfrom{%
%\hangindent=\wd\@tempboxa\hangafter=-10
\hskip #3\relax{\csname #2@font\endcsname \@svsecAPPSTAR}}%%
       \interlinepenalty \@M %\@secjidori
\shortstack[l]{%
%\noindent\box\@tempboxa
\noindent
#8}\@@par}%
   \endgroup
}
%%%%
  \ifdim \wd\SECTwd > \columnwidth
%%%% 
%    \begingroup
   \noindent%\parbox[t]{\columnwidth}
{\vskip-.25\Cvs\begingroup%
\noindent
      #6{%
        \@hangfrom{\hskip #3\relax\@svsecAPPSTAR}%
          \interlinepenalty \@M 
\noindent\hangindent\wd\@tempboxb\hangafter=1
#8\@@par}\addvspace{-.125\Cvs}%
    \endgroup}
\else
    \noindent\begingroup\noindent%\hfil
\hfil%
%%%% 
\ifdim\ht\SECTwd >\baselineskip
%%%%%%
\parbox[t]{\wd\SECTwd}{%
      #6{%\pushtowall{$\star\star$}%
        \@hangfrom{\hskip #3\relax\@svsecAPPSTAR}%
          \interlinepenalty \@M
#8\@@par}\addvspace{.125\Cvs}
}%
    \endgroup
%%%%%%
\else
%%%%%%
\parbox[t]{\wd\SECTwd}{%
      #6{%\pushtowall{@}%
        \@hangfrom{\hskip #3\relax\@svsecAPPSTAR}%
          \interlinepenalty \@M
#8\@@par}}%
    \endgroup
%%%%%%
\fi
\fi
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechdAPPSTAR{\let\@makefnmark\sec@makefnmark%
      #6{\hskip #3\relax
      \@svsecAPPSTAR #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsectAPPSTAR{#5}}
\def\@xsectAPPSTAR#1{%
  \@tempskipa #1\relax
  \ifdim \@tempskipa>\z@
    \par \nobreak
    \vskip \@tempskipa
    \@afterheading
  \else
    \@nobreakfalse
    \global\@noskipsectrue
    \everypar{%
      \if@noskipsec
        \global\@noskipsecfalse
       {\setbox\z@\lastbox}%
        \clubpenalty\@M
        \begingroup \@svsechdAPPSTAR \endgroup
        \unskip
        \@tempskipa #1\relax
        \hskip -\@tempskipa
      \else
        \clubpenalty \@clubpenalty
        \everypar{}%
      \fi}%
  \fi
  \ignorespaces}

\def\@seccntformatAPPSTAR#1{\bfseries Appendix% \csnamethe#1\endcsname
\quad
}


\def\@ssectAPPSTAR#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
%%%
\setbox\SECTwd=\hbox{%
\begingroup\noindent
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M %
\shortstack[l]{
\noindent
#5}\@@par}%
    \endgroup
}
%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \ifdim \wd\SECTwd > \columnwidth
   \noindent%
{\begingroup{\large\bfseries Appendix\hskip1em}%
      #4{\let\@makefnmark\sec@makefnmark%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M 
\noindent%\hangindent\wd\@tempboxb\hangafter=1
#5\@@par}%
    \endgroup}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\else
    \noindent\begingroup\hfil{\large\bfseries Appendix\hskip1em}%
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
\fi
  \else
    \def\@svsechdAPPSTAR{#4{\hskip #1\relax #5}}%
  \fi
  \@xsectAPPSTAR{#3}}





\def\AppendixNoCNT{%
%\newcommand{\appendix*}{%
 \setcounter{section}{-1}%
 \setcounter{subsection}{0}%
 \setcounter{secnumdepth}{2}%
 \setcounter{equation}{0}%
 \setcounter{figure}{-1}%
 \setcounter{table}{0}%
 \@addtoreset{equation}{section}%
 \@addtoreset{figure}{section}%
 \@addtoreset{table}{section}%
 \def\theequation{A.\protect\,\@arabic\c@equation}%
%  \def\thesection{Appendix~\@Alph\c@section}%
 \def\thesection{A}%
 \def\thesubsection{A.\protect\,\@arabic\c@subsection}%
% \def\fnum@figure{Fig.\protect\,A.\@arabic\c@figure}%
% \def\fnum@table{Table~A.\@arabic\c@table}%
 \def\fnum@figure{Fig.~A.\@arabic\c@figure}%
 \def\fnum@table{Table~A.\@arabic\c@table}%
 \def\thefigure{A.\@arabic\c@figure}%
 \def\thetable{A.\@arabic\c@table}%
\def\@thmcountersep{A.}%%% 
%%%%%%%%%%%%%%5
%\refstepcounter{equation}%{1}
%\refstepcounter{section}%
%\refstepcounter{subsection}%
%\refstepcounter{figure}%
%\refstepcounter{table}%
%\refstepcounter{section}%
%}
\renewcommand{\section}{\@startsectionAPPSTAR{section}{1}{0em}%
%   {.00001\Cvs \@plus.00001mm \@minus.00001mm}%
  {1\Cvs \@plus.00001mm \@minus.00001mm}%
   {.00001mm}%
   {\reset@font\large%\slshape
\bfseries
\mathversion{bold}%
}}
%}
}








\renewenvironment{thebibliography}[1]
     {%
%
\renewcommand{\section}{\@startsection{section}{1}{0em}%
   {.00001\Cvs \@plus.00001mm \@minus.5mm \addvspace{-1mm}}%
   {1.00001mm  \@minus.5mm}%
   {\reset@font\large%\slshape
\bfseries
\mathversion{bold}%
}}
%
\small\section*{\small\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
        \topsep\z@\parsep\z@\partopsep\z@\itemsep\z@
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}









%%% From File: ltthm.dtx
%%% section= 
\def\newtheorem#1{%
  \@ifnextchar[{\@othm{#1}}{\@nthm{#1}}}
\def\@nthm#1#2{%
  \@ifnextchar[{\@xnthm{#1}{#2}}{\@ynthm{#1}{#2}}}
\def\@xnthm#1#2[#3]{%
  \expandafter\@ifdefinable\csname #1\endcsname
    {\@definecounter{#1}\@newctr{#1}[#3]%
     \expandafter\xdef\csname the#1\endcsname{%
       \expandafter\noexpand\csname the#3\endcsname \@thmcountersep
          \@thmcounter{#1}}%
     \global\@namedef{#1}{\@thm{#1}{#2}}%
     \global\@namedef{end#1}{\@endtheorem}}}
\def\@ynthm#1#2{%
  \expandafter\@ifdefinable\csname #1\endcsname
    {\@definecounter{#1}%
     \expandafter\xdef\csname the#1\endcsname{\@thmcounter{#1}}%
     \global\@namedef{#1}{\@thm{#1}{#2}}%
     \global\@namedef{end#1}{\@endtheorem}}}
\def\@othm#1[#2]#3{%
  \@ifundefined{c@#2}{\@nocounterr{#2}}%
    {\expandafter\@ifdefinable\csname #1\endcsname
    {\global\@namedef{the#1}{\@nameuse{the#2}}%
  \global\@namedef{#1}{\@thm{#2}{#3}}%
  \global\@namedef{end#1}{\@endtheorem}}}}
\def\@thm#1#2{%
  \refstepcounter{#1}%
  \@ifnextchar[{\@ythm{#1}{#2}}{\@xthm{#1}{#2}}}
\def\@xthm#1#2{%
  \@begintheorem{#2}{\csname the#1\endcsname}\ignorespaces}
\def\@ythm#1#2[#3]{%
  \@opargbegintheorem{#2}{\csname the#1\endcsname}{#3}\ignorespaces}
\def\@thmcounter#1{\noexpand\arabic{#1}}
\def\@thmcountersep{.}%%% 
\def\@begintheorem#1#2{\trivlist
   \item[\hskip \labelsep{{\bfseries #1\ #2}}]}
\def\@opargbegintheorem#1#2#3{\trivlist
%      \item[\hskip \labelsep{{\bfseries #1\ #2\ {(#3)}}}]}
      \item[\hskip \labelsep{{\bfseries #1\ #2\ (#3{\bfseries)}}}]}
\def\@endtheorem{\endtrivlist}














%\def\acknowledgment{\par
%  \section*{\hspace*{-58mm}Acknowledgment}}
%\def\endacknowledgment{\par}



%\newcommand{\acknowledgment}{\section*{\hspace*{-58mm}Acknowledgment}}
\newcommand{\acknowledgments}{\section*{Acknowledgments}}









%\newcommand{\subsubsection}{\@startsectionC{subsubsection}{3}{0em}%
%   {.00001\Cvs \@plus.1mm \@minus.1mm}%
%   {.00001\Cvs \@plus.1mm \@minus.1mm}%
%   {\reset@font\normalsize}}



\newcommand{\Introduction}{\@startsectionC{section}{1}{0em}%
%   {.00001\Cvs \@plus.00001mm \@minus.00001mm}%
%   {.00001\Cvs \@plus.00001mm \@minus.00007mm}%
   {.000001mm}%
   {.00001\Cvs \@plus.00001mm \@minus.00007mm}%
   {\reset@font\large%\slshape
\bfseries
\mathversion{bold}%
}}


\newcommand{\introduction}{\Introduction{Introduction}}





\def\Newpage{\linebreak\newpage\noindent}






\def\QED{{\fboxsep\z@\fboxrule.1mm
 \unskip\nobreak\hfil\penalty50
 \hskip2.75mm\hbox{}\nobreak\hfil 
  \mbox{\smash{\fbox{\rule{0mm}{3mm}\rule{1.5mm}{0mm}}}\hskip1em}%
 \parfillskip\z@ \finalhyphendemerits\z@\par}}




\def\BQED{{\fboxsep\z@\fboxrule.1mm
 \unskip\nobreak\hfil\penalty50
 \hskip2.75mm\hbox{}\nobreak\hfil \mbox{\smash{\rule{1.5mm}{3mm}}\hskip1em}%
 \parfillskip\z@ \finalhyphendemerits\z@\par}}




\vbadness10001


\endinput
%%
%% End of file `article.cls'.





