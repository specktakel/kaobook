%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kaobook
% LaTeX Class
% Version 0.9.8 (2021/08/23)
%
% This template originates from:
% https://www.LaTeXTemplates.com
%
% For the latest template development version and to make contributions:
% https://github.com/fmarotta/kaobook
%
% Authors:
% Federico Marotta (federicomarotta@mail.com)
% Based on the doctoral thesis of Ken Arroyo Ohori (https://3d.bk.tudelft.nl/ken/en)
% and on the Tufte-LaTeX class.
% Modified for LaTeX Templates by Vel (vel@latextemplates.com)
%
% License:
% LPPL (see included MANIFEST.md file)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kaobook}[2021/08/23 v0.9.8 kaobook]
\newcommand{\@baseclass}{scrbook} % Base class name

% Set the default options
\PassOptionsToClass{a4paper}{\@baseclass}
\PassOptionsToClass{fontsize=10pt}{\@baseclass}
\PassOptionsToClass{parskip=half}{\@baseclass}
\PassOptionsToClass{headings=optiontoheadandtoc}{\@baseclass}

% --- Class options
% title page font style
\newif\if@titlepage@sansserif
\DeclareOption{seriftitlepage}{\@titlepage@sansseriffalse}%
\DeclareOption{sansseriftitlepage}{\@titlepage@sansseriftrue}%
% title page layout lines
\newif\if@titlepage@showlayout
\DeclareOption{layouttitlepage}{\@titlepage@showlayouttrue}%
\DeclareOption{nolayouttitlepage}{\@titlepage@showlayoutfalse}%
% add toc to toc
\newif\if@addtoctotoc
\DeclareOption{addtoctotoc}{\@addtoctotoctrue}%
\DeclareOption{notocintoc}{\@addtoctotocfalse}%
% pass remaining options to scrbook class

% Pass through any other options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@baseclass}} 

\ExecuteOptions{seriftitlepage,nolayouttitlepage,addtoctotoc}%
\ProcessOptions\relax % Process the options

\LoadClass{\@baseclass} % Load the base class

\RequirePackage{kao} % Load the code common to all classes

% --- Load packages
% use manual text positioning on title page
\if@titlepage@showlayout
  \RequirePackage[showboxes,absolute]{textpos}%
\else
  \RequirePackage[absolute]{textpos}%
\fi

\RequirePackage[pgfplots,svgnames,x11names]{tumcolor}%

% --- Document properties
% parameters as set by the main file.
\newcommand{\faculty}[1]{\def\@faculty{#1}}%
\newcommand{\degree}[1]{\def\@degree{#1}}%
\newcommand{\vorsitz}[1]{\def\@vorsitz{#1}}%
\newcommand{\erstpruef}[1]{\def\@erstpruef{#1}}%


\newif\ifzweitpruefaffil
\newcommand{\zweitpruef}[2][]{%
  \def\@zweitpruef{#2}
  \ifx#1\empty\else
    \def\@zweitpruefaffil{#1}
    \zweitpruefaffiltrue
  \fi
}

\newif\ifdrittpruefset
\newif\ifdrittpruefaffil
\newcommand{\drittpruef}[2][]{%
  \ifx#2\empty\else
    \drittpruefsettrue
    \def\@drittpruef{#2}
    \ifx#1\empty\else
      \def\@drittpruefaffil{#1}
      \drittpruefaffiltrue
    \fi
  \fi
}



% --- Titlepage
% The title page is fully centered.
\def\titlepagebindingcor#1{\def\@titlepagebindingcor{#1}}
\def\@titlepagebindingcor{0mm}
\RequirePackage{calc}%

\def\TUMLogoWidth{19mm}

% Left and right margins are exactly the same.
\def\defaultwidth{150mm}%
\def\defaulthpos{30mm + \@titlepagebindingcor}%

% Vertical positions of title page entities
\def\titlevpos{100.2mm}%
\def\informationvpos{147mm}%
\def\examinervpos{196.5mm}%
\def\datevpos{241mm}%

% --- Robustify
% clear textpos box
% textpos interacts badly with some packages due to a conflict with \shipout
% https://tex.stackexchange.com/questions/66804/unexpected-output-using-tikz-textpos
\def\cleartextposbox{\global\setbox\TP@holdbox\vbox{}}

\AtBeginDocument{%
% pdf links: only if hyperref was loaded in main file
\@ifpackageloaded{hyperref}{%
  \hypersetup{%
    bookmarks    = true,         % show bookmarks bar?
    pdftoolbar   = true,         % show Acrobat’s toolbar?
    pdfmenubar   = true,         % show Acrobat’s menu?
    pdffitwindow = false,        % window fit to page when opened
    pdfstartview = {FitH},       % fits the width of the page to the window
    pdftitle     = {\@title},    % title
    pdfauthor    = {\@author},   % author
    pdfsubject   = {PhD Thesis}, % subject of the document
    pdfcreator   = {\@author},   % creator of the document
    pdfnewwindow = true,         % links in new window
  }}{}%
}

% Title Page
\renewcommand\maketitle{%
\begin{titlepage}
    \if@titlepage@sansserif
      \sffamily
    \fi



    % Layouting helper
    \if@titlepage@showlayout
      % Logo box with 105% size rel. to TUM logo
      \begin{textblock*}{10.5mm}(9.75mm, 9.75mm)
          \hspace{1mm} \vspace{10.5mm}
      \end{textblock*}

      % top and bottom margin check for logo and fak text
      \begin{textblock*}{180mm}(25mm, 10mm)
          \hspace{1mm} \vspace{10mm}
      \end{textblock*}

      \begin{textblock*}{190mm}(10mm, 148.5mm) % mid
          \noindent\makebox[\hsize]{\rule{\textwidth}{1pt}}
      \end{textblock*}

      \begin{textblock*}{190mm}(10mm, 99mm) % first third
          \noindent\makebox[\hsize]{\rule{\textwidth}{1pt}}
      \end{textblock*}

      \begin{textblock*}{190mm}(10mm, 198mm) % second third
          \noindent\makebox[\hsize]{\rule{\textwidth}{1pt}}
      \end{textblock*}
    \fi



    % Logos
    % FAK logo
    \input{fak_placement.tex}

    % FAK text
    %                         See TUM CD Handbook page 16
    %                         x    + x    + 0.5x
    \begin{textblock*}{120mm}(10mm + 10mm + 5mm + \@titlepagebindingcor, 13.78mm)
        \footnotesize
        \fontfamily{phv}\selectfont
        \noindent \textcolor{TUMBlue}{
          {\@faculty}
        }\\
        \fontfamily{phv}\selectfont
        \textcolor{TUMBlue}{
          Technische Universit\"at M\"unchen
        }
    \end{textblock*}

    % TUM logo
    \begin{textblock*}{\TUMLogoWidth}(\paperwidth - \TUMLogoWidth - 10mm, 10mm)
        \noindent \includegraphics[height = 10mm]{graphics/TUM.pdf}
    \end{textblock*}



    % Titel und Autor
    % Keep the name position fixed. Longer titles expand towards top.
    \begin{textblock*}{\defaultwidth}[0,1](\defaulthpos, \titlevpos)
        \centering

        {\bfseries \Large \textcolor{TUMBlue} \@title}
        \ifdefempty{\@subtitle}{}{\vspace{1ex}\bfseries\large \@subtitle}

        \vspace{10mm}

        {\bfseries \large \@author}\\

    \end{textblock*}



    % Informationstext
    \begin{textblock*}{\defaultwidth}(\defaulthpos, \informationvpos)
        \centering
        \raggedright

        Vollst\"andiger Abdruck der von der {\@faculty} der Technischen
        Universit\"at M\"unchen zur Erlangung des akademischen Grades eines\\

        \vspace{6mm}

        \centering {\bfseries \large {\@degree}}\\

        \vspace{6mm}
        \raggedright

        genehmigten Dissertation.\\

    \end{textblock*}



    % Prüfer
    \begin{textblock*}{\defaultwidth}(\defaulthpos, \examinervpos)
        \centering
        \raggedright

        \textbf{Vorsitzender:}\\
        \hspace{8mm}\hphantom{1. }\@vorsitz

        \vspace{2mm}

        \textbf{Pr\"ufende der Dissertation:}\\
        \hspace{8mm}1. \@erstpruef\\
        \hspace{8mm}2. \@zweitpruef
        \ifzweitpruefaffil
          ,\\\hspace{8mm}\hphantom{2. }\@zweitpruefaffil
        \fi
        \ifdrittpruefset
          \\\hspace{8mm}3. \@drittpruef
          \ifdrittpruefaffil
            ,\\\hspace{8mm}\hphantom{2. }\@drittpruefaffil
          \fi
        \fi

    \end{textblock*}



    % Daten
    \begin{textblock*}{\defaultwidth}(\defaulthpos, \datevpos)
        \raggedright

        Die Dissertation wurde am .. . .. . .... bei der Technischen Universit\"at
        M\"unchen eingereicht und durch die {\@faculty}
        am .. . .. . ....
        angenommen.

    \end{textblock*}

\end{titlepage}

% force empty page
\mbox{}
\newpage
\thispagestyle{empty}
\null\newpage\cleartextposbox

} % end \renewcommand\maketitle

%----------------------------------------------------------------------------------------
%	FRONT-, MAIN-, BACK- MATTERS BEHAVIOUR
%----------------------------------------------------------------------------------------

% Front matter
\let\oldfrontmatter\frontmatter % Store the old command
\renewcommand{\frontmatter}{%
	\oldfrontmatter% First of all, call the old command
	\pagestyle{scrheadings}% Use a plain style for the header and the footer
	\pagelayout{wide}% Use a wide page layout
	\setchapterstyle{plain} % Choose the default chapter heading style
	% \sloppy % Required to better break long lines
}

%------------------------------------------------

% Main matter
\let\oldmainmatter\mainmatter % Store the old command
\renewcommand{\mainmatter}{%
	\oldmainmatter% Call the old command
	\pagestyle{scrheadings}% Use a fancy style for the header and the footer
	\pagelayout{margin}% Use a 1.5 column layout
	\setchapterstyle{kao} % Choose the default chapter heading style
}

%------------------------------------------------

% Appendix
\let\oldappendix\appendix% Store the old command
\renewcommand{\appendix}{%
	\oldappendix% Call the old command
	\bookmarksetup{startatroot}% Reset the bookmark depth
}

%------------------------------------------------

% Back matter
\let\oldbackmatter\backmatter% Store the old command
\renewcommand{\backmatter}{%
	\oldbackmatter% Call the old command
	\bookmarksetup{startatroot}% Reset the bookmark depth
	\pagestyle{plain.scrheadings}% Use a plain style for the header and the footer
	\pagelayout{wide}% Use a wide page layout
	\setchapterstyle{plain} % Choose the default chapter heading style
}

%----------------------------------------------------------------------------------------
%	CHAPTER HEADING STYLES
%----------------------------------------------------------------------------------------

% Command to easily switch between chapter styles
\DeclareDocumentCommand{\setchapterstyle}{m}{%
	\ifthenelse{\equal{plain}{#1}}{\chapterstyleplain}{}
	\ifthenelse{\equal{bar}{#1}}{\chapterstylebar}{}
	\ifthenelse{\equal{lines}{#1}}{\chapterstylelines}{}
	\ifthenelse{\equal{kao}{#1}}{\chapterstylekao}{}
}

% The default definition in KOMA script
\DeclareDocumentCommand{\chapterstyleplain}{}{%
	\renewcommand{\chapterlinesformat}[3]{%
		\@hangfrom{##2}{##3}}
	\renewcommand*{\chapterformat}{%
		\mbox{\chapappifchapterprefix{\nobreakspace}\thechapter%
		\autodot\IfUsePrefixLine{}{\enskip}}}
	\RedeclareSectionCommand[beforeskip=0cm,afterskip=10\vscale]{chapter}
	\setlength{\mtocshift}{-1\vscale}
}

% Gray bar
\DeclareDocumentCommand{\chapterstylebar}{}{%
	\renewcommand*{\chapterformat}{%
		\mbox{\chapappifchapterprefix{\nobreakspace}\thechapter%
		\autodot\IfUsePrefixLine{}{\enskip}}%
	}
	\renewcommand{\chapterlinesformat}[3]{%
		\begin{tikzpicture}[remember picture, overlay]
			\node[
				anchor=south west,
				xshift=\dimexpr - \hoffset - \oddsidemargin - 1in -1mm,%-30\hscale,
				yshift=4.3mm,
				rectangle,
				fill=gray!20!white,
				fill opacity=0.8,
				inner ysep=5\vscale,
				inner xsep=\dimexpr \hoffset + \oddsidemargin + 1in,%30\hscale,
				text opacity=1,
				text width=\paperwidth-40\hscale,
			]{\@hangfrom{##2}{##3}};
		\end{tikzpicture}
	}
	\RedeclareSectionCommand[beforeskip=-55\vscale,afterskip=6\vscale]{chapter}
	\setlength{\mtocshift}{-1\vscale}
}

% Lines
\renewcommand{\hrulefill}[1][0.4pt]{%
	\leavevmode\leaders\hrule height #1\hfill\kern\z@%
}
\DeclareDocumentCommand{\chapterstylelines}{}{%
	\renewcommand*{\chapterformat}{%
		\chapappifchapterprefix{\nobreakspace}\scalebox{3.5}{\thechapter\autodot}%
	}%
	\renewcommand\chapterlinesformat[3]{%
		%\vspace*{-1cm}%
		\leavevmode%
		\makebox[0pt][l]{%
		\makebox[\textwidth][l]{\hrulefill[1pt]##2}%\hfill%\par%\bigskip
		\makebox[\marginparsep][l]{}%
		\makebox[\marginparwidth][l]{}%
		}\\
		%\vspace{.5cm}
		\makebox[0pt][l]{%
		\makebox[\textwidth][l]{##3}%
		\makebox[\marginparsep][l]{}%
		\makebox[\marginparwidth][l]{}%
		}\\
		\makebox[0pt][l]{%
		\makebox[\textwidth+\marginparsep+\marginparwidth][l]{\hrulefill[1.1pt]}%
		}%
	}%
	\RedeclareSectionCommand[beforeskip=0cm,afterskip=10\vscale]{chapter}
	\setlength{\mtocshift}{-1\vscale}%
}

% The Kao style
\DeclareDocumentCommand{\chapterstylekao}{}{%
    \IfWideLayout{%
        \renewcommand*{\chapterformat}{%
	    	\mbox{\chapappifchapterprefix{\nobreakspace}\scalebox{2.85}{\thechapter\autodot}}%
	    }%
	    \renewcommand\chapterlinesformat[3]{%
	    	\vspace{3.5\vscale}%
	    	\if@twoside%
	    		\Ifthispageodd{%
	    			\smash{\makebox[0pt][l]{%
                        \parbox[b]{\textwidth - 6.2\hscale}{\flushright{##3}}%
                        \makebox[6.2\hscale][c]{\rule[-2\vscale]{1pt}{27.4\vscale+\f@size mm}}%
	    				\parbox[b]{\marginparwidth}{##2}%
	    			}}%
	    		}{
                    \smash{\makebox[\textwidth + 6.2\hscale][r]{%
                        \parbox[b]{47.7\hscale + 6.2\hscale}{\flushright{##2}}%
                        \makebox[6.2\hscale][c]{\rule[-2\vscale]{1pt}{27.4\vscale+\f@size mm}}%
	    				\parbox[b]{\textwidth}{\flushleft{##3}}%
	    			}}%
	    		}
	    	\else%
	    		\smash{\makebox[0pt][l]{%
                    \parbox[b]{\textwidth - 6.2\hscale}{\flushright{##3}}%
                    \makebox[6.2\hscale][c]{\rule[-2\vscale]{1pt}{27.4\vscale+\f@size mm}}%
                    \parbox[b]{\marginparwidth}{##2}%
	    		}}%
	    	\fi%
	    }%
    }{%
        \renewcommand*{\chapterformat}{%
	    	\mbox{\chapappifchapterprefix{\nobreakspace}\scalebox{2.85}{\thechapter\autodot}}%
	    }%
	    \renewcommand\chapterlinesformat[3]{%
	    	\vspace{3.5\vscale}%
	    	\if@twoside%
	    		\Ifthispageodd{%
	    			\smash{\makebox[0pt][l]{%
	    				\parbox[b]{\textwidth}{\flushright{##3}}%
	    				\makebox[\marginparsep][c]{\rule[-2\vscale]{1pt}{27.4\vscale+\f@size mm}}%
	    				\parbox[b]{\marginparwidth}{##2}%
	    			}}%
	    		}{
	    			\smash{\makebox[\textwidth][r]{%
	    				\parbox[b]{\marginparwidth}{\flushright{##2}}%
	    				\makebox[\marginparsep][c]{\rule[-2\vscale]{1pt}{27.4\vscale+\f@size mm}}%
	    				\parbox[b]{\textwidth}{\flushleft{##3}}%
	    			}}%
	    		}
	    	\else%
	    		\smash{\makebox[0pt][l]{%
	    			\parbox[b]{\textwidth}{\flushright{##3}}%
	    			\makebox[\marginparsep][c]{\rule[-2\vscale]{1pt}{27.4\vscale+\f@size mm}}%
	    			\parbox[b]{\marginparwidth}{##2}%
	    		}}%
	    	\fi%
	    }%
    }%
	\RedeclareSectionCommand[beforeskip=0cm,afterskip=10\vscale]{chapter}%
	\setlength{\mtocshift}{-3.5\vscale}%
}

% Takes as input the image path and optionally the "beforeskip"
\DeclareDocumentCommand{\setchapterimage}{O{55\vscale} m}{%
	\setchapterpreamble[o]{%
		\vspace*{-27\vscale}\hspace*{\dimexpr - \hoffset - \oddsidemargin - 1in}%
		\includegraphics[width=\paperwidth,height=#1+27\vscale,keepaspectratio=false]{#2}%
	}%
	\chapterstylebar%
	% beforeskip=-(figure_height-top_margin)
	\RedeclareSectionCommand[beforeskip=-#1, afterskip=6\vscale]{chapter}%
	\setlength{\mtocshift}{0cm}%
}

% By default start with the plain style
\chapterstyleplain

%----------------------------------------------------------------------------------------
%	FONTS AND STYLES
%----------------------------------------------------------------------------------------

% Set KOMA fonts for book-specific elements
\addtokomafont{part}{\normalfont\scshape\bfseries}
\addtokomafont{partentry}{\normalfont\scshape\bfseries}
\addtokomafont{chapter}{\normalfont\bfseries}
\addtokomafont{chapterentry}{\normalfont\bfseries}

% Set KOMA fonts for elements common to all classes
\addtokomafont{section}{\normalfont\bfseries}
\addtokomafont{subsection}{\normalfont\bfseries}
\addtokomafont{subsubsection}{\normalfont\bfseries}
\addtokomafont{paragraph}{\normalfont\bfseries}
\setkomafont{descriptionlabel}{\normalfont\bfseries}

%----------------------------------------------------------------------------------------
%	TOC, LOF & LOT
%----------------------------------------------------------------------------------------

% Set default options regarding the table of contents
\PassOptionsToClass{toc=listof}{\@baseclass}
\PassOptionsToClass{toc=index}{\@baseclass}
\PassOptionsToClass{toc=bibliography}{\@baseclass}

%----------------------------------------------------------------------------------------
%	NUMBERING
%----------------------------------------------------------------------------------------

%\setcounter{secnumdepth}{\kao@secnumdepth} % Set section numbering depth

\counterwithin*{sidenote}{chapter} % Uncomment to reset the sidenote counter at each chapter
%\counterwithout{sidenote}{chapter} % Uncomment to have one sidenote counter for the whole document
