\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{techreport}[2026/06/09 Technical report class]

% =========================================================
% BASE CLASS
% =========================================================
\LoadClass[a4paper]{article}

% =========================================================
% FONT + LANGUAGE (must be early)
% =========================================================
\RequirePackage{fontspec}
\RequirePackage{polyglossia}

\setdefaultlanguage{russian}
\setmainlanguage{russian}

\setmainfont{Times New Roman}
\newfontfamily\cyrillicfont{Times New Roman}
\setmonofont{DejaVu Sans Mono}

% =========================================================
% TYPOGRAPHY IMPROVEMENTS
% =========================================================
\RequirePackage{microtype}

% =========================================================
% MATH SYSTEM (NO DUPLICATES)
% =========================================================
\RequirePackage[fleqn]{mathtools}
\RequirePackage{amssymb}

% =========================================================
% SCIENTIFIC UNITS
% =========================================================
\RequirePackage{siunitx}

% =========================================================
% GRAPHICS + TIKZ
% =========================================================
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
\pgfplotsset{
	report plot/.style={
			width=0.9\textwidth,
			height=0.55\textwidth,
			grid=major
		}
}

\usetikzlibrary{
	matrix,
	positioning,
	shapes.geometric,
	arrows.meta,
	decorations.pathmorphing
}

\tikzset{
startstop/.style={
		rectangle, rounded corners,
		minimum width=3cm,
		minimum height=1cm,
		draw=black
	},
process/.style={
		rectangle,
		minimum width=3cm,
		minimum height=1cm,
		draw=black
	},
decision/.style={
		diamond,
		aspect=2,
		draw=black
	},
arrow/.style={
-{Stealth},
thick
},
state/.style={
		circle,
		draw,
		minimum size=1.5cm,
		align=center
	},
terminalcondition/.style={
		state,
		double,
		double distance=2pt
	}
}

% =========================================================
% TABLES + LISTS
% =========================================================
\RequirePackage{enumitem}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{tabularx}
\RequirePackage{makecell}

% =========================================================
% COLORS
% =========================================================
\RequirePackage[table]{xcolor}
\RequirePackage{ulem}
\normalem

% =========================================================
% PAGE GEOMETRY
% =========================================================
\RequirePackage{geometry}

\geometry{
	left=3cm,
	right=1.5cm,
	top=2cm,
	bottom=2cm
}

% =========================================================
% HEADERS / FOOTERS
% =========================================================
\RequirePackage{fancyhdr}

% =========================================================
% HYPERREF + BOOKMARK (ORDER CRITICAL)
% =========================================================
\usepackage{xurl}
\RequirePackage{hyperref}
\hypersetup{
	colorlinks=false,
	pdfborder={0 0 0}
}

\RequirePackage{bookmark}

\RequirePackage{cleveref}
\crefname{figure}{рисунок}{рисунки}
\crefname{table}{таблицу}{таблицы}

% =========================================================
% CAPTIONS
% =========================================================
\RequirePackage[labelsep=endash,justification=centering]{caption}

\captionsetup[figure]{name=Рисунок}

% =========================================================
% TOC + HEADINGS
% =========================================================
\RequirePackage{tocloft}
\RequirePackage{titlesec}

\newcommand{\ReportFontSize}{14}
\newcommand{\ReportFontSkip}{16}

\AtBeginDocument{
	\fontsize{\ReportFontSize}{\ReportFontSkip}\selectfont
}

\renewcommand{\cftsecfont}{\normalfont\fontsize{\ReportFontSize}{\ReportFontSkip}\selectfont}
\renewcommand{\cftsubsecfont}{\normalfont\fontsize{\ReportFontSize}{\ReportFontSkip}\selectfont}
\renewcommand{\cftsecpagefont}{\normalfont\fontsize{\ReportFontSize}{\ReportFontSkip}\selectfont}
\renewcommand{\cfttoctitlefont}{\normalfont\fontsize{\ReportFontSize}{\ReportFontSkip}\selectfont}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}

\titleformat{\section}
{\normalfont\fontsize{\ReportFontSize}{\ReportFontSkip}\selectfont}
{\thesection}{1em}{}

\titleformat{\subsection}
{\normalfont\fontsize{\ReportFontSize}{\ReportFontSkip}\selectfont}
{\thesubsection}{1em}{}

\titleformat{\subsubsection}
{\normalfont\fontsize{\ReportFontSize}{\ReportFontSkip}\selectfont}
{\thesubsubsection}{1em}{}


\newcommand{\cutesection}[1]{%
	\section*{#1}%
	\phantomsection%
	\addcontentsline{toc}{section}{#1}%
}

% =========================================================
% Section command
% =========================================================
\newcommand{\cutesubsection}[1]{%
	\subsection*{#1}%
	\phantomsection%
	\addcontentsline{toc}{subsection}{#1}%
}

\newcommand{\cutesubsubsection}[1]{%
	\subsubsection*{#1}%
	\phantomsection%
	\addcontentsline{toc}{subsubsection}{#1}%
}

% =========================================================
% CODE LISTINGS (IMPORTANT: minted requires -shell-escape)
% =========================================================
\RequirePackage{minted}

\setminted{
	fontsize=\footnotesize,
	breaklines=true,
	autogobble=true,
	tabsize=4,
	frame=none
}

\RequirePackage{longtable}
\RequirePackage{pgfplotstable}
\RequirePackage{seqsplit}

% =========================================================
% METADATA STORAGE (CLEAN API)
% =========================================================
\newcommand{\studentname}{}
\newcommand{\studentgroup}{}
\newcommand{\discipline}{}
\newcommand{\worknumber}{}
\newcommand{\worktopic}{}
\newcommand{\instructor}{}
\newcommand{\instructorpost}{}

% =========================================================
% Setters
% =========================================================
\pgfkeys{
	/techreport/.is family, /techreport,
	student-name/.store in=\studentname,
	student-group/.store in=\studentgroup,
	discipline/.store in=\discipline,
	work-number/.store in=\worknumber,
	work-topic/.store in=\worktopic,
	instructor-post/.store in=\instructorpost,
	instructor/.store in=\instructor,
}

\newcommand{\setreport}[1]{%
	\pgfkeys{/techreport,#1}%
}
% =========================================================
% TITLE PAGE COMPONENTS
% =========================================================

\newcommand{\ReportHeader}{%
	\centering

	\begin{minipage}{0.15\textwidth}
		\includegraphics[width=\linewidth]{logo.png}
	\end{minipage}
	\hfill
	\begin{minipage}{0.8\textwidth}
		\centering
		\textbf{\fontsize{9pt}{10pt}\selectfont
			МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РФ\\
			ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ\\
			ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ\\
			«МОСКОВСКИЙ АВИАЦИОННЫЙ ИНСТИТУТ»\\}
	\end{minipage}

	\vspace{0.5cm}

	\begin{tikzpicture}[remember picture,overlay]
		\draw[line width=2pt]
		(current page.west|-0,0) -- (current page.east|-0,0);
	\end{tikzpicture}

	\vspace{0.8cm}

	Институт №3 «Системы управления, информатика и электроэнергетика»\\
	Кафедра 304 «Вычислительные машины, системы и сети»
}

\newcommand{\ReportTitleBlock}{%
	\vfill
	{\fontsize{14pt}{16pt}\selectfont
		Отчет по лабораторной работе № \worknumber\\
		По дисциплине «\discipline»\\
		По теме «\worktopic»
	}
	\vfill
}

\newcommand{\ReportSignatureBlock}{%
	\begin{flushright}
		Выполнил: студент гр. \studentgroup\\
		\studentname\\
		\vspace{1em}
		Проверил: \instructorpost\\
		\instructor
	\end{flushright}
}

\newcommand{\makereporttitle}{%
	\begin{titlepage}
		\thispagestyle{empty}
		\setlength{\parindent}{1.25cm}

		\ReportHeader

		\vfill
		\ReportTitleBlock
		\vfill
		\ReportSignatureBlock
		\vfill

		Москва \the\year

	\end{titlepage}

	\clearpage
}


