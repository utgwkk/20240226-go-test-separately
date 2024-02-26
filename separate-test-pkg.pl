use strict;
use warnings;
use JSON::PP qw(encode_json);

# separated-test-pkgs.txt から、個別にテストを実行したいパッケージを取得する
my @separated_test_pkgs = do {
    open my $fh, '<', 'separated-test-pkgs.txt' or die $!;
    chomp (my @xs = <$fh>);
    close $fh;
    @xs;
};
# package名 => 個別にテストを実行したいなら true
my %is_separated_test_pkg = map { $_ => 1 } @separated_test_pkgs;

# このモジュール下のパッケージ一覧を取得する
my @all_pkgs = split "\n", `go list ./...`;

# 同時にテストを実行してよいパッケージのみを抽出する
my @independent_pkgs = grep { !$is_separated_test_pkg{$_} } @all_pkgs;

# JSON形式で出力する (フォーマットは __END__ 以下を参照)
my $outputs = [
    (
        map {
            +{
                name     => $_,
                packages => [$_],
            }
        } @separated_test_pkgs
    ),
    +{
        name     => 'Others',
        packages => [@independent_pkgs],
    },
];
print encode_json $outputs;

__END__
[
    {
        "name": "github.com/utgwkk/20240226-go-test-separately/b",
        "packages": [
            "github.com/utgwkk/20240226-go-test-separately/b"
        ]
    },
    {
        "name": "github.com/utgwkk/20240226-go-test-separately/c",
        "packages": [
            "github.com/utgwkk/20240226-go-test-separately/c"
        ]
    },
    {
        "name": "github.com/utgwkk/20240226-go-test-separately/d",
        "packages": [
            "github.com/utgwkk/20240226-go-test-separately/d"
        ]
    },
    {
        "name": "Others",
        "packages": [
            "github.com/utgwkk/20240226-go-test-separately/a",
            "github.com/utgwkk/20240226-go-test-separately/e",
            "github.com/utgwkk/20240226-go-test-separately/f",
            "github.com/utgwkk/20240226-go-test-separately/g",
            "github.com/utgwkk/20240226-go-test-separately/h",
            "github.com/utgwkk/20240226-go-test-separately/i",
            "github.com/utgwkk/20240226-go-test-separately/j",
            "github.com/utgwkk/20240226-go-test-separately/k",
            "github.com/utgwkk/20240226-go-test-separately/l",
            "github.com/utgwkk/20240226-go-test-separately/m",
            "github.com/utgwkk/20240226-go-test-separately/n",
            "github.com/utgwkk/20240226-go-test-separately/o",
            "github.com/utgwkk/20240226-go-test-separately/p",
            "github.com/utgwkk/20240226-go-test-separately/q",
            "github.com/utgwkk/20240226-go-test-separately/r",
            "github.com/utgwkk/20240226-go-test-separately/s",
            "github.com/utgwkk/20240226-go-test-separately/t",
            "github.com/utgwkk/20240226-go-test-separately/u",
            "github.com/utgwkk/20240226-go-test-separately/v",
            "github.com/utgwkk/20240226-go-test-separately/w",
            "github.com/utgwkk/20240226-go-test-separately/x",
            "github.com/utgwkk/20240226-go-test-separately/y",
            "github.com/utgwkk/20240226-go-test-separately/z"
        ]
    }
]
