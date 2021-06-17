const likeCase = (bool: boolean) =>
  `CASE WHEN "isLike" = ${bool} THEN 1 ELSE 0 END`;

export const reactionCount = (table: string, reaction: boolean) =>
  `(SELECT sum(${likeCase(
    reaction,
  )}) FROM "${table}_reaction" WHERE "${table}"."id" = "${table}_reaction"."${table}Id")`;
