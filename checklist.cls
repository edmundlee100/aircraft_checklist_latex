\ProvidesClass{checklist}
\NeedsTeXFormat{LaTeX2e}

% Class options
\RequirePackage{ifthen}
\newboolean{sim-use}
\newboolean{halfpage}
\DeclareOption{sim-use}{\setboolean{sim-use}{true}}
\DeclareOption{halfpage}{\setboolean{halfpage}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[twocolumn, 11pt, a4paper]{article}

% Define custom macro definitions
\newcommand{\logo}[1]{\def\@logo{#1}}
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand{\version}[1]{\def\@version{#1}}

\RequirePackage{environ}
\RequirePackage{setspace}
\RequirePackage{svg}
\RequirePackage{xcolor}

\definecolor{customblack}{gray}{0.15}
\newcommand{\blank}{\underline{\hspace{5mm}}}    % underlined empty space

% Change margin and column width
\RequirePackage{geometry}
\geometry{textwidth=7.25in, columnsep=0.35in, tmargin=1.0in, bmargin=2.25in}

% Change font family
\usepackage[scaled]{helvet}
\renewcommand\familydefault{\sfdefault} 
\usepackage[T1]{fontenc}


% Header and footer
\RequirePackage{fancyhdr}
\RequirePackage{tabularx, multirow, makecell, colortbl}
\setlength{\headheight}{1.7in}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[L]{\ifthenelse{\boolean{sim-use}}{For simulation use only}{}}
\fancyhead[C]{%
    % \setlength{\extrarowheight}{0.6in}   % use \rule to specific row height instead
    \newcolumntype{C}{>{\centering\arraybackslash}m}
    \newcolumntype{Y}{>{\centering\arraybackslash}X}
    \newcolumntype{N}{@{}m{0pt}@{}}
    % \renewcommand{\tabularxcolumn}[1]{C{#1}}
    
    \begin{tabularx}{\textwidth}{|C{1.5in}|Y|C{1.5in}|N}
        \hline
        % https://tex.stackexchange.com/questions/445943/center-a-multirow -- 5 lines work better than 2
        \cellcolor{customblack} & & \cellcolor{customblack}\textcolor{white}{\makecell{\@subtitle}} & \rule{0pt}{4pc}\\
        \cline{3-3}
        \multirow{-5}{*}{\cellcolor{customblack}\includegraphics[width=1.5in]{\@logo}} &
        \multirow{-5}{*}{\LARGE{\@title}} &
        \makecell{\@version} & \rule{0pt}{4pc}\\        
        \hline
    \end{tabularx}%    
}


% For creating box around each section
\RequirePackage{tcolorbox}
\tcbset{colback=white, colframe=customblack, arc=0mm, beforeafter skip=6mm,
    fonttitle=\bfseries\large, halign title=center, 
    boxsep=0mm, toptitle=3mm, bottomtitle=3mm, top=4mm, bottom=4mm}


% Checklist environment for each section
\newenvironment{checklist}[1]{%
    \newcommand{\indentspace}{0em}
    \renewcommand{\item}[2]{%
        \hspace*{\indentspace}##1\,\dotfill\,\uppercase{##2} \\
    }

    \newcommand{\condition}[2]{%
        \renewcommand{\indentspace}{1.5em}
        \textit{##1} \\ ##2
        \renewcommand{\indentspace}{0em}
    }

    \begin{tcolorbox}[title=\uppercase{#1}]
    \setstretch{1.1}
}{%
    \vspace*{-\baselineskip}
    \end{tcolorbox}
}

