% Inclass assignment 9
%GB comments
1) 100
2) 100
3) 100 
4) 100
Overall: 100


% The accession number for human NOTCH1 mRNA is AF308602
% 1. Read the information from this entry into matlab

% Define accession number
accession = 'AF308602';

% Get data from genbank
genbank_dat = getgenbank(accession);

% 2. Write code that runs a blast query on the first 500 base pairs of this
% gene against the refseq_rna database

% Cut first 500 base pairs from genbank data for NOTCH1
first_500 = genbank_dat.Sequence(1:500);

% Access the NCBI BLAST database, specifically the refseq_rna database
[requestID, requestTime] = blastncbi(first_500, 'blastn', 'Database', 'refseq_rna');
blast_data = getblast(requestID, 'WaitTime', 1.1 * requestTime);

% 3. Find the three highest scoring hits from other species and identify
% the length of the alignment and fraction of matches/mismatches. 

% Highest Scoring Hit:
highest_data1 = blast_data.Hits(1).HSPs(1).Identities;
length_1 = highest_data1.Possible;
match_frac1 = highest_data1.Percent;

disp(' ')
fprintf('For best hit, length is %d and fraction of matches/mismatches is %d. \n', length_1, match_frac1);

% 2nd Highest Scoring Hit:
highest_data2 = blast_data.Hits(2).HSPs(1).Identities;
length_2 = highest_data2.Possible;
match_frac2 = highest_data2.Percent;

disp(' ')
fprintf('For second best hit, length is %d and fraction of matches/mismatches is %d. \n', length_2, match_frac2);

% 3rd Highest Scoring Hit:
highest_data3 = blast_data.Hits(3).HSPs(1).Identities;
length_3 = highest_data3.Possible;
match_frac3 = highest_data3.Percent;

disp(' ')
fprintf('For third best hit, length is %d and fraction of matches/mismatches is %d. \n', length_3, match_frac3);
disp(' ')

% 4. Run the same query against the database est_human. Comment on the
% sequences that you find. 

[requestID2, requestTime2] = blastncbi(first_500, 'blastn', 'Database', 'est_human');
blast_data2 = getblast(requestID2, 'WaitTime', 1.1 * requestTime2);

query_indices = blast_data2.Hits(1).HSPs.QueryIndices;
subject_indices = blast_data2.Hits(1).HSPs.SubjectIndices;

% It appears that the sequence that our 500 base pairs matches the best is
% a NOTCH1 mRNA sequence. This is expected, as the data was pulled for
% NOTCH1 mRNA. However, the query indices and subject indices show that the
% best allignment occurs at the end of the query sequence and the beginning
% of our 500 base pairs. This indicates that the mRNA base pair sequence in
% the BLAST database for human NOTCH1 is a bit offset from the sequence we 
% are giving it.
